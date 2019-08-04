#ifndef __UIXOBJECTS_H__
#define __UIXOBJECTS_H__

#include "DataStructures.h"
#include "UIXRenderer.h"
#include <stdarg.h>
#include <string.h>

void inputboxclick(char* inputboxtext);

class UIXDrawContext{
    public:
    unsigned short* dispmem=NULL;
    int pagestarty;
    int pageendy;
    int refreshsp;
    int refreshep;
};

class UIXTouchContext{
    public:
    unsigned short touchx=0,touchy=0,touchz=0;
    bool touchpressed=false;
    unsigned short lasttouchx=0,lasttouchy=0,lasttouchz=0;
    bool lasttouchpressed=false;
};

//background touchindicator button label inputbox 
class UIXObject{
    protected:
    public:
    bool drawn;
    bool redraw;
    virtual void draw(UIXDrawContext* context);
    virtual void tick(UIXTouchContext* context);
    virtual void updaterefresharea(int* refreshsp,int* refreshep,int pagestarty,int pageendy);
    UIXObject(){
        redraw=true;
    }
};

class UIXBackground : public UIXObject{
    public:
    unsigned short col;
    void draw(UIXDrawContext* context){
        UIXRenderer::clear(context->dispmem,context->pagestarty,context->pageendy,COLDARKGRAY,context->refreshsp,context->refreshep);
        UIXRenderer::drawrectangle(context->dispmem,context->pagestarty,context->pageendy,0,239,0,289,COLVSBLUE,context->refreshsp,context->refreshep);
        UIXRenderer::drawrectangle(context->dispmem,context->pagestarty,context->pageendy,3,239-3,3,289-3,COLBLACK,context->refreshsp,context->refreshep);
        //UIXRenderer::drawstring(context->dispmem,context->pagestarty,context->pageendy,(unsigned char*)"Test string",11,100,100,0xFFFF,context->refreshsp,context->refreshep,2);
    }
    void tick(UIXTouchContext* context){

    }
    void updaterefresharea(int* refreshsp,int* refreshep,int pagestarty,int pageendy){
        UIXRenderer::updaterefresharea(refreshsp,refreshep,pagestarty,pageendy,0,319);
    }
    UIXBackground(unsigned short col_){
        drawn=true;
        col=col_;
    }
};

class UIXTouchIndicator : public UIXObject{
    private:
    unsigned short touchx_,touchy_,touchz_;
    bool touchpressed_;
    unsigned short lasttouchx_,lasttouchy_,lasttouchz_;
    bool lasttouchpressed_;
    public:
    unsigned short col;
    void draw(UIXDrawContext* context){
        unsigned char siz=touchz_/256;
        if(siz>9)siz=9;
        if(touchpressed_){
            UIXRenderer::drawrectangleframe(context->dispmem,context->pagestarty,context->pageendy,\
            touchx_-siz,touchx_+siz,touchy_-siz,touchy_+siz,col,context->refreshsp,context->refreshep);
        }
    }
    void tick(UIXTouchContext* context){
        lasttouchpressed_=touchpressed_;
        lasttouchx_=touchx_;lasttouchy_=touchy_;lasttouchz_=touchz_;
        touchx_=context->touchx;touchy_=context->touchy;touchz_=context->touchz;
        touchpressed_=context->touchpressed;
        if(touchpressed_||lasttouchpressed_) redraw=true;
    }
    void updaterefresharea(int* refreshsp,int* refreshep,int pagestarty,int pageendy){
        UIXRenderer::updaterefresharea(refreshsp,refreshep,pagestarty,pageendy,touchy_-10,touchy_+10);
        UIXRenderer::updaterefresharea(refreshsp,refreshep,pagestarty,pageendy,lasttouchy_-10,lasttouchy_+10);
    }
    UIXTouchIndicator(unsigned short col_){
        drawn=true;
        col=col_;
    }
};

class UIXDynamicText : public UIXObject{
    public:
    unsigned short col,x,y,scale;
    unsigned char font;
    char* str;
    int len=0;
    void draw(UIXDrawContext* context){
        UIXRenderer::drawstring(context->dispmem,context->pagestarty,context->pageendy,(unsigned char*)str,len,x,y,col,context->refreshsp,context->refreshep,scale,font);
    }
    void tick(UIXTouchContext* context){

    }
    void invalidate(){
        redraw=true;
        len=strlen(str);
    }
    void updaterefresharea(int* refreshsp,int* refreshep,int pagestarty,int pageendy){
        switch(font){
            case 0:
            UIXRenderer::updaterefresharea(refreshsp,refreshep,pagestarty,pageendy,y,y+scale*8);
            break;
            case 1:
            UIXRenderer::updaterefresharea(refreshsp,refreshep,pagestarty,pageendy,y,y+scale*32);
            break;
            default:
            return;
        }
    }
    UIXDynamicText(char* str_,unsigned short col_,unsigned short x_,unsigned short y_,unsigned short scale_,unsigned char font_=0){
        drawn=true;
        str=str_;len=strlen(str);
        col=col_;x=x_;y=y_;scale=scale_;font=font_;
    }
};

class UIXButton : public UIXObject{
    private:
    int capx=0,capy=0;
    int caplen=0;
    int clickcooldown=0;
    public:
    bool pressed=false;
    unsigned short col,colhighlight;
    int l=0,r=0,t=0,b=0;
    char* capstr;
    int tag=0;
    bool animated;
    bool border;
    int animatei=0;
    bool selected=false;
    void (*clickcallback)(int,UIXButton*);
    void draw(UIXDrawContext* context){
        if((pressed || selected) && border)
            UIXRenderer::drawrectangle(context->dispmem,context->pagestarty,context->pageendy,l-2,r+2,t-2,b+2,colhighlight,context->refreshsp,context->refreshep);
        UIXRenderer::drawrectangle(context->dispmem,context->pagestarty,context->pageendy,l,r,t,b,col,context->refreshsp,context->refreshep);
        UIXRenderer::drawstring(context->dispmem,context->pagestarty,context->pageendy,(unsigned char*)capstr,caplen,capx,capy,COLWHITE,context->refreshsp,context->refreshep,1,0);
        if(pressed || selected)
            UIXRenderer::drawrectangle(context->dispmem,context->pagestarty,context->pageendy,l,r,t/8+7*b/8,b,colhighlight,context->refreshsp,context->refreshep);
        if(animatei>0 && border){
            int borderexpansion=animatei;
            if(borderexpansion>5) borderexpansion=5+(borderexpansion-5)/2;
            if(borderexpansion>7) borderexpansion=7+(borderexpansion-7)/2;
            UIXRenderer::drawrectangleframe(context->dispmem,context->pagestarty,context->pageendy,l-borderexpansion,r+borderexpansion,t-borderexpansion,b+borderexpansion,colhighlight,context->refreshsp,context->refreshep);
        }
        if(animatei>0){
            int highlightpos=t/8+7*b/8+animatei/2;
            if(highlightpos<b)
                UIXRenderer::drawrectangle(context->dispmem,context->pagestarty,context->pageendy,l,r,highlightpos,b,colhighlight,context->refreshsp,context->refreshep);
        }
    }
    void tick(UIXTouchContext* context){
        if(clickcooldown>0) clickcooldown--;
        if(animatei>0){
            animatei++;
            if(animatei>15) animatei=0;
            redraw=true;
        }
        if(pressed){
            redraw=true;
        }
        if((!context->lasttouchpressed) && context->touchpressed){
            if(context->touchx>l && context->touchx<r && context->touchy>t && context->touchy<b){
                pressed=true;
            }
        }
        if(context->lasttouchpressed && (!context->touchpressed) && pressed){
            if(context->lasttouchx>l && context->lasttouchx<r && context->lasttouchy>t && context->lasttouchy<b){
                if(clickcooldown==0){
                    clickcallback(tag,this);
                    clickcooldown=10;
                    if(animated)
                        animatei=1;
                }
            }
            pressed=false;
        }
    }
    void updaterefresharea(int* refreshsp,int* refreshep,int pagestarty,int pageendy){
        UIXRenderer::updaterefresharea(refreshsp,refreshep,pagestarty,pageendy,t-10,b+10);
    }
    UIXButton(int l_,int r_,int t_,int b_,unsigned short col_,unsigned short colhighlight_,char* capstr_,void(*clickcallback_)(int,UIXButton*),int tag_=0,bool animated_=true,bool border_=true){
        drawn=true;
        l=l_;r=r_;t=t_;b=b_;col=col_;colhighlight=colhighlight_;
        capstr=capstr_;caplen=strlen(capstr);
        clickcallback=clickcallback_;
        tag=tag_;
        animated=animated_;border=border_;
        capy=(t+b)/2-4;
        capx=(l+r)/2-6*strlen(capstr)/2;
    }
};

class UIXInputBox : public UIXObject{
    private:
    bool pressed;
    int clickcooldown=10;
    public:
    int l,r,t,b;
    unsigned short col,colhighlight;
    char* text;
    int tag;
    bool animated;
    int animatei=0;
    void draw(UIXDrawContext* context){
        if(!pressed)
            UIXRenderer::drawrectangle(context->dispmem,context->pagestarty,context->pageendy,l,r,t,b,col,context->refreshsp,context->refreshep);
        else
            UIXRenderer::drawrectangle(context->dispmem,context->pagestarty,context->pageendy,l-1,r+1,t-1,b+1,colhighlight,context->refreshsp,context->refreshep);
        UIXRenderer::drawrectangle(context->dispmem,context->pagestarty,context->pageendy,l+2,r-2,t+2,b-2,COLBLACK,context->refreshsp,context->refreshep);
        int ypos=t/2+b/2-4;
        UIXRenderer::drawstring(context->dispmem,context->pagestarty,context->pageendy,(unsigned char*)text,strlen(text),l+3+8,ypos,COLWHITE,context->refreshsp,context->refreshep,1,0);
    }
    void tick(UIXTouchContext* context){
        if(pressed){
            redraw=true;
        }
        if(animatei>0){
            animatei++;
            if(animatei>15) animatei=0;
            redraw=true;
        }
        if(clickcooldown>0)clickcooldown--;
        if((!context->lasttouchpressed) && context->touchpressed){
            if(context->touchx>l && context->touchx<r && context->touchy>t && context->touchy<b){
                pressed=true;
            }
        }
        if(context->lasttouchpressed && (!context->touchpressed) && pressed){
            if(context->lasttouchx>l && context->lasttouchx<r && context->lasttouchy>t && context->lasttouchy<b){
                if(clickcooldown==0){
                    //clicked
                    inputboxclick(text);
                    clickcooldown=10;
                    //if(animated)
                    //    animatei=1;
                }
            }
            pressed=false;
        }
    }
    void invalidate(){
        redraw=true;
    }
    void updaterefresharea(int* refreshsp,int* refreshep,int pagestarty,int pageendy){
        UIXRenderer::updaterefresharea(refreshsp,refreshep,pagestarty,pageendy,t-3,b+3);
    }
    UIXInputBox(int l_,int r_,int t_,int b_,unsigned short col_,unsigned short colhighlight_,char* text_,int tag_=0,bool animated_=true){
        drawn=true;pressed=false;
        l=l_;r=r_;t=t_;b=b_;
        col=col_;colhighlight=colhighlight_;text=text_;tag=tag_;animated=animated_;
    }
};

class UIXSlider : public UIXObject{
    public:
    int l,r,t,b;
    int col,colhighlight;
    bool animated;
    bool pressed;
    int animatei;
    double percentage=0.0;
    int blockwidth=12;
    void draw(UIXDrawContext* context){
        int center=t/2+b/2;
        UIXRenderer::drawrectangle(context->dispmem,context->pagestarty,context->pageendy,l,r,center-1,center,COLGRAY,context->refreshsp,context->refreshep);
        int blockcenter=l+blockwidth/2+(int)(percentage*(r-l-blockwidth));
        if(!pressed){
            UIXRenderer::drawrectangle(context->dispmem,context->pagestarty,context->pageendy,blockcenter-blockwidth/2,blockcenter+blockwidth/2,t,b,col,context->refreshsp,context->refreshep);
        }else{
            UIXRenderer::drawrectangle(context->dispmem,context->pagestarty,context->pageendy,blockcenter-blockwidth/2-1,blockcenter+blockwidth/2+1,t-1,b+1,colhighlight,context->refreshsp,context->refreshep);
        }
        if(animatei>0){
            int borderexpansion=animatei;
            if(borderexpansion>5) borderexpansion=5+(borderexpansion-5)/2;
            if(borderexpansion>7) borderexpansion=7+(borderexpansion-7)/2;
            UIXRenderer::drawrectangleframe(context->dispmem,context->pagestarty,context->pageendy,blockcenter-blockwidth/2-borderexpansion,blockcenter+blockwidth/2+borderexpansion,t-borderexpansion,b+borderexpansion,colhighlight,context->refreshsp,context->refreshep);
        }
    }
    void tick(UIXTouchContext* context){
        if(pressed){
            redraw=true;
        }
        if(animatei>0){
            animatei++;
            if(animatei>15) animatei=0;
            redraw=true;
        }
        int blockcenter=l+blockwidth/2+(int)(percentage*(r-l-blockwidth));
        if((!context->lasttouchpressed) && context->touchpressed){
            if(context->touchx>l && context->touchx<r && context->touchy>t && context->touchy<b){
                pressed=true;
            }
        }
        if(context->lasttouchpressed && (!context->touchpressed) && pressed){
            if(animated) animatei=1;
            pressed=false;
        }
        if(pressed){
            double newpercentage;
            newpercentage=(double)(context->touchx-(l+blockwidth/2));
            newpercentage=newpercentage/(double)(r-l-blockwidth);
            percentage=0.5*percentage+0.5*newpercentage;
            if(percentage<0.0)percentage=0.0;
            if(percentage>1.0)percentage=1.0;
        }
    }
    void updaterefresharea(int* refreshsp,int* refreshep,int pagestarty,int pageendy){
        UIXRenderer::updaterefresharea(refreshsp,refreshep,pagestarty,pageendy,t-15,b+15);
    }
    UIXSlider(int l_,int r_,int t_,int b_,unsigned short col_,unsigned short colhighlight_,bool animated_=true){
        drawn=true;
        l=l_;r=r_;t=t_;b=b_;
        col=col_;colhighlight=colhighlight_;
        animated=animated_;
    }
};

#define UIXCONSOLELINES 21
bool uixconinvokecallback=false;    //currently, button click callback function does not have a pointer type argument
void uixconsolebtnsendcallback(int tag,UIXButton* btn){
    uixconinvokecallback=true;
}
class UIXConsole : public UIXObject{
    private:
    UIXDynamicText* dtl[UIXCONSOLELINES];
    char* dtlcont[UIXCONSOLELINES];
    char* dtlconttmp;
    int dtlpt=0;
    UIXInputBox* inpt;
    char* inputstr;
    UIXButton* btnsnd;
    bool invalidated=true;
    void (*sndcallback)(char* str);
    
    int pt=0;

    public:
    void draw(UIXDrawContext* context){
        for(int i=0;i<UIXCONSOLELINES;i++){
            dtl[i]->draw(context);
            if(context->pageendy>=319)//last page temp fix
                dtl[i]->redraw=false;
        }
        inpt->draw(context);
        btnsnd->draw(context);
        //UIXRenderer::drawline(context->dispmem,context->pagestarty,context->pageendy,10,10,51+(pt%100),250,COLWHITE,context->refreshsp,context->refreshep,true);
        pt+=5;
    }
    void tick(UIXTouchContext* context){
        if(uixconinvokecallback){
            uixconinvokecallback=false;
            sndcallback(inputstr);
        }
        inpt->tick(context);
        btnsnd->tick(context);
        if(invalidated){
            redraw=true;
            invalidated=false;
        }else{
            redraw=false;
        }
        if(inpt->redraw||btnsnd->redraw) redraw=true;
    }
    void updaterefresharea(int* refreshsp,int* refreshep,int pagestarty,int pageendy){
        
        for(int i=0;i<UIXCONSOLELINES;i++){
            if(dtl[i]->redraw)
                dtl[i]->updaterefresharea(refreshsp,refreshep,pagestarty,pageendy);
        }
        if(inpt->redraw) inpt->updaterefresharea(refreshsp,refreshep,pagestarty,pageendy);
        if(btnsnd->redraw) btnsnd->updaterefresharea(refreshsp,refreshep,pagestarty,pageendy);
    }
    int log(const char* format,...){
        int dtlptprevprev=dtlpt==0?(UIXCONSOLELINES-2):(dtlpt==1?(UIXCONSOLELINES-1):(dtlpt-2));
        int dtlptprev=dtlpt==0?(UIXCONSOLELINES-1):(dtlpt-1);
        int dtlptnext=(dtlpt+1)%UIXCONSOLELINES;
        va_list vl;
        va_start(vl,format);

        dtlcont[dtlptprevprev][0]=' ';
        dtl[dtlptprevprev]->col=COLGRAY;
        dtl[dtlptprevprev]->invalidate();

        dtlcont[dtlptprev][0]=' ';
        dtl[dtlptprev]->col=COLLIGHTGRAY;
        dtl[dtlptprev]->invalidate();

        int ret=vsprintf(dtlconttmp,format,vl);
        dtlcont[dtlpt][0]='>';
        dtlcont[dtlpt][1]='\0';
        dtlcont[dtlpt]=strcat(dtlcont[dtlpt],dtlconttmp);
        dtl[dtlpt]->col=COLWHITE;
        dtl[dtlpt]->invalidate();

        dtlcont[dtlptnext][0]=' ';
        dtlcont[dtlptnext][1]='\0';
        dtl[dtlptnext]->invalidate();

        va_end(vl);
        dtlpt=dtlptnext;
        invalidated=true;
        return ret;
    }
    UIXConsole(void (*sndcallback_)(char* str)){
        drawn=true;
        sndcallback=sndcallback_;
        dtlconttmp=new char[100];
        inputstr=new char[100];
        inputstr[0]='\0';
        for(int i=0;i<UIXCONSOLELINES;i++){
            dtlcont[i]=new char[100];
            dtlcont[i][0]=' ';
            dtlcont[i][1]='\0';
            dtl[i]=new UIXDynamicText(dtlcont[i],COLWHITE,18,20+10*i,1,0);
        }
        inpt=new UIXInputBox(20,150,240,270,COLVSORANGE,COLORANGE,inputstr);
        btnsnd=new UIXButton(160,220,240,270,COLVSORANGE,COLORANGE,"Send",uixconsolebtnsendcallback);
    }
};

class UIXPlot : public UIXObject{
    private:
    char tickstr[30]={'\0'};
    public:
    int l,r,t,b;
    int frame;
    double* ptxlist;
    double* ptylist;
    double ptxmin,ptxmax,ptymin,ptymax;
    double meshx,meshy;
    bool tickx,ticky;
    unsigned short col;
    public:
    int pts=200;
    void draw(UIXDrawContext* context){
        int w=r-l;int h=b-t;
        if(frame>1){    //mesh
            int meshlimit,meshi,mshx,mshy;
            //x axis
            int xaxisy=(int)((double)b-(0.0-ptymin)/(ptymax-ptymin)*h);
            if(xaxisy>=t&&xaxisy<=b){
                UIXRenderer::drawline(context->dispmem,context->pagestarty,context->pageendy,l,xaxisy,r,xaxisy,COLDARKGRAY,context->refreshsp,context->refreshep,true);
                if(ticky){
                    sprintf(tickstr,"0");
                    UIXRenderer::drawstring(context->dispmem,context->pagestarty,context->pageendy,(unsigned char*)tickstr,strlen(tickstr),l-3-6*strlen(tickstr),xaxisy-4,COLLIGHTGRAY,context->refreshsp,context->refreshep);
                }
            }
            //y axis
            int yaxisx=(int)((double)l+(0.0-ptxmin)/(ptxmax-ptxmin)*w);
            if(yaxisx>=l&&yaxisx<=r){
                UIXRenderer::drawline(context->dispmem,context->pagestarty,context->pageendy,yaxisx,t,yaxisx,b,COLDARKGRAY,context->refreshsp,context->refreshep,true);
                if(tickx){
                    sprintf(tickstr,"0");
                    UIXRenderer::drawstring(context->dispmem,context->pagestarty,context->pageendy,(unsigned char*)tickstr,strlen(tickstr),yaxisx-3*strlen(tickstr),b+3,COLLIGHTGRAY,context->refreshsp,context->refreshep);
                }
            }
            //mesh and ticks
            {
                //x+ mesh
                meshlimit=1000;
                meshi=1;
                do{
                    mshx=(int)((double)l+(meshx*meshi-ptxmin)/(ptxmax-ptxmin)*w);
                    if(mshx<r&&mshx>l){
                        UIXRenderer::drawline(context->dispmem,context->pagestarty,context->pageendy,mshx,t,mshx,b,COLDARKGRAY,context->refreshsp,context->refreshep,false);
                        
                        if(tickx){
                            sprintf(tickstr,"%d",(int)(meshx*meshi));
                            UIXRenderer::drawstring(context->dispmem,context->pagestarty,context->pageendy,(unsigned char*)tickstr,strlen(tickstr),mshx-3*strlen(tickstr),b+3,COLLIGHTGRAY,context->refreshsp,context->refreshep);
                        }
                    }else{
                        if(mshx>=r) break;
                    }
                    meshi++;
                    meshlimit--;
                }while(meshlimit>0);
                //x- mesh
                meshlimit=1000;
                meshi=-1;
                do{
                    mshx=(int)((double)l+(meshx*meshi-ptxmin)/(ptxmax-ptxmin)*w);
                    if(mshx<r&&mshx>l){
                        UIXRenderer::drawline(context->dispmem,context->pagestarty,context->pageendy,mshx,t,mshx,b,COLDARKGRAY,context->refreshsp,context->refreshep,false);
                        if(tickx){
                            sprintf(tickstr,"%d",(int)(meshx*meshi));
                            UIXRenderer::drawstring(context->dispmem,context->pagestarty,context->pageendy,(unsigned char*)tickstr,strlen(tickstr),mshx-3*strlen(tickstr),b+3,COLLIGHTGRAY,context->refreshsp,context->refreshep);
                        }
                    }else{
                        if(mshx<=l)break;
                    }
                    meshi--;
                    meshlimit--;
                }while(meshlimit>0);

                //y+ mesh
                meshlimit=1000;
                meshi=1;
                do{
                    mshy=(int)((double)b-(meshi*meshy-ptymin)/(ptymax-ptymin)*h);
                    if(mshy<b&&mshy>t){
                        UIXRenderer::drawline(context->dispmem,context->pagestarty,context->pageendy,l,mshy,r,mshy,COLDARKGRAY,context->refreshsp,context->refreshep,false);
                        if(ticky){
                            sprintf(tickstr,"%d",(int)(meshy*meshi));
                            UIXRenderer::drawstring(context->dispmem,context->pagestarty,context->pageendy,(unsigned char*)tickstr,strlen(tickstr),l-3-6*strlen(tickstr),mshy-4,COLLIGHTGRAY,context->refreshsp,context->refreshep);
                        }
                    }else{
                        if(mshy<=t)break;
                    }
                    meshi++;
                    meshlimit--;
                }while(meshlimit>0);

                //y- mesh
                meshlimit=1000;
                meshi=-1;
                do{
                    mshy=(int)((double)b-(meshi*meshy-ptymin)/(ptymax-ptymin)*h);
                    if(mshy<b&&mshy>t){
                        UIXRenderer::drawline(context->dispmem,context->pagestarty,context->pageendy,l,mshy,r,mshy,COLDARKGRAY,context->refreshsp,context->refreshep,false);
                        if(ticky){
                            sprintf(tickstr,"%d",(int)(meshy*meshi));
                            UIXRenderer::drawstring(context->dispmem,context->pagestarty,context->pageendy,(unsigned char*)tickstr,strlen(tickstr),l-3-6*strlen(tickstr),mshy-4,COLLIGHTGRAY,context->refreshsp,context->refreshep);
                        }
                    }else{
                        if(mshy>=b)break;
                    }
                    meshi--;
                    meshlimit--;
                }while(meshlimit>0);
            }
        }
        //draw frame
        if(frame>0){    //outer frame
            UIXRenderer::drawrectangleframe(context->dispmem,context->pagestarty,context->pageendy,l,r,t,b,COLLIGHTGRAY,context->refreshsp,context->refreshep);
            UIXRenderer::drawrectangleframe(context->dispmem,context->pagestarty,context->pageendy,l+1,r-1,t+1,b-1,COLLIGHTGRAY,context->refreshsp,context->refreshep);
        }
        //draw pts
        int ptax,ptay,ptbx,ptby;
        ptax=(int)((double)l+(ptxlist[0]-ptxmin)/(ptxmax-ptxmin)*w);
        ptay=(int)((double)b-(ptylist[0]-ptymin)/(ptymax-ptymin)*h);
        if(ptax<l)ptax=l;   //not accurate
        if(ptax>r)ptax=r;
        if(ptay<t)ptay=t;
        if(ptay>b)ptay=b;
        for(int i=1;i<pts;i++){
            ptbx=(int)((double)l+(ptxlist[i]-ptxmin)/(ptxmax-ptxmin)*w);
            ptby=(int)((double)b-(ptylist[i]-ptymin)/(ptymax-ptymin)*h);
            if(ptbx<l)ptbx=l;   //not accurate
            if(ptbx>r)ptbx=r;
            if(ptby<t)ptby=t;
            if(ptby>b)ptby=b;
            UIXRenderer::drawline(context->dispmem,context->pagestarty,context->pageendy,ptax,ptay,ptbx,ptby,col,context->refreshsp,context->refreshep,true);
            ptax=ptbx;
            ptay=ptby;
        }
    }
    void tick(UIXTouchContext* context){

    }
    void updaterefresharea(int* refreshsp,int* refreshep,int pagestarty,int pageendy){
        UIXRenderer::updaterefresharea(refreshsp,refreshep,pagestarty,pageendy,t-10,b+10);
    }
    void invalidate(){
        redraw=true;
    }
    UIXPlot(int l_,int r_,int t_,int b_,double* ptxlist_,double* ptylist_,double ptxmin_,double ptxmax_,double ptymin_,double ptymax_,unsigned short col_,int frame_=2,bool tickx_=false,bool ticky_=false){
        l=l_;r=r_;t=t_;b=b_;
        ptxlist=ptxlist_;ptylist=ptylist_;
        ptxmin=ptxmin_;ptxmax=ptxmax_;ptymin=ptymin_;ptymax=ptymax_;
        col=col_;
        frame=frame_;tickx=tickx_;ticky=ticky_;
        meshx=(ptxmax-ptxmin)/5;
        meshy=(ptymax-ptymin)/5;
        drawn=true;
        redraw=true;
    }
};

class UIXObjectDerived : public UIXObject{
    public:
    void draw(UIXDrawContext* context){

    }
    void tick(UIXTouchContext* context){

    }
    void updaterefresharea(int* refreshsp,int* refreshep,int pagestarty,int pageendy){

    }
    UIXObjectDerived(){
        drawn=true;
    }
};

#endif
