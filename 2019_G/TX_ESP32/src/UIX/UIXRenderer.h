#ifndef __UIXRENDERER_H__
#define __UIXRENDERER_H__

#include "FontAssets.h"

class UIXRenderer{
    public:

    //r g b 0 to 32
    static unsigned short makecolor(unsigned char r,unsigned g,unsigned b){
        g*=2;
        unsigned char highbyte,lowbyte;
        highbyte=((unsigned char)r<<3)+((unsigned char)g>>3);
        lowbyte=((unsigned char)g<<5)+(unsigned char)b;
        return ((unsigned short)lowbyte<<8)+highbyte;
    }
    //page y range is pagestarty<=pagey<pageendy
    static bool updaterefresharea(int* refreshsp,int* refreshep,int pagestarty,int pageendy,int objecttopy,int objectbottomy){
        bool inpage=false;
        if(!(objecttopy>pageendy || objectbottomy<pagestarty)){
            inpage=true;
            int objecttopry=objecttopy-pagestarty,objectbottomry=objectbottomy-pagestarty;
            if(objecttopry<0)objecttopry=0;
            if(objectbottomry>=pageendy-pagestarty) objectbottomry=(pageendy-pagestarty)-1;
            if(*refreshsp>objecttopry) *refreshsp=objecttopry;
            if(*refreshep<objectbottomry) *refreshep=objectbottomry;
        }
        return inpage;
    }

    static void clear(unsigned short* dispmem,int pagestarty,int pageendy,unsigned short col,int refreshsp=0,int refreshep=319){
        int pagelen=pageendy-pagestarty-1;
        for(int ry=refreshsp;ry<=pagelen && ry<=refreshep;ry++){
            for(int x=0;x<=239;x++){
                dispmem[240*ry+x]=col;
            }
        }
    }

    static void drawrectangle(unsigned short* dispmem,int pagestarty, int pageendy, int l,int r,int t,int b,unsigned short col,int refreshsp=0,int refreshep=319){
        int xsp=l,xep=r,ysp=t-pagestarty,yep=b-pagestarty;
        if(ysp<0) ysp=0;
        if(yep>=pageendy-pagestarty) yep=pageendy-pagestarty-1;
        if(xsp<0) xsp=0;
        if(xep>=240) xep=239;
        if(ysp<refreshsp) ysp=refreshsp;
        for(int ry=ysp; ry<=yep && ry<=refreshep; ry++){
            for(int x=xsp;x<=xep;x++){
                dispmem[240*ry+x]=col;
            }
        }
    }

    static void drawrectangleframe(unsigned short* dispmem,int pagestarty, int pageendy, int l,int r,int t,int b,unsigned short col,int refreshsp=0,int refreshep=319){
        int xsp=l,xep=r,ysp=t-pagestarty,yep=b-pagestarty;
        if(ysp<0) ysp=0;
        if(yep>=pageendy-pagestarty) yep=pageendy-pagestarty-1;
        if(xsp<0) xsp=0;
        if(xep>=240) xep=239;
        if(ysp<refreshsp) ysp=refreshsp;
        for(int ry=ysp; ry<=yep && ry<=refreshep; ry++){
            for(int x=xsp;x<=xep;x++){
                //TODO IMPROVE PERFORMANCE
                if(ry+pagestarty==t || ry+pagestarty==b || x==l || x==r)
                    dispmem[240*ry+x]=col;
            }
        }
    }

    static void drawcharacter(unsigned short* dispmem,int pagestarty,int pageendy,unsigned char chr,int x,int y,unsigned short col,int refreshsp=0,int refreshep=319,unsigned char scale=1,unsigned char font=1){
        if(chr>=32&&chr<=127){
            //possible performance boost here: test y
            unsigned char fontwidth,fontheight;
            switch(font){
                case 0://fontdata_small6x8
                fontwidth=8;fontheight=8;
                break;
                case 1://fontdata_big16x32
                fontwidth=16;fontheight=32;
                break;
                default:
                return;
            }
            for(int gpy=0;gpy<fontheight;gpy++){
                unsigned short chrrow;
                if(font==0)
                    chrrow=fontdata_small6x8[chr-32][gpy];
                else
                    chrrow=fontdata_big16x32[chr-32][gpy];
                for(int gpx=0;gpx<fontheight;gpx++){
                    int gppxy=y+gpy*scale, gppxx=x+gpx*scale;
                    int gppxry=gppxy-pagestarty;
                    //test pixel
                    if(chrrow>>(fontwidth-1-gpx)&0x01){
                        for(int i=0;i<scale;i++){
                            int ry=gppxry+i;
                            if(ry>=0 && ry>=refreshsp && ry<=refreshep && ry<pageendy-pagestarty){
                                for(int j=0;j<scale;j++){
                                    int rx=gppxx+j;
                                    if(rx>=0&&rx<240){
                                        dispmem[240*ry+rx]=col;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    static void drawstring(unsigned short* dispmem,int pagestarty,int pageendy,unsigned char* str,unsigned char len,int x,int y,unsigned short col,int refreshsp=0,int refreshep=319,unsigned char scale=1,unsigned char font=0){
        unsigned char fontspacing;
        switch(font){
            case 0:
            fontspacing=6;
            break;
            case 1:
            fontspacing=16;
            break;
            default:
            return;
        }
        for(int i=0;i<len;i++){
            drawcharacter(dispmem,pagestarty,pageendy,str[i],x+i*scale*fontspacing,y,col,refreshsp,refreshep,scale,font);
        }
    }

    static void drawline(unsigned short*dispmem,int pagestarty,int pageendy,int xa,int ya,int xb,int yb,unsigned short col,int refreshsp=0,int refreshep=319,bool thick=false){
        int xas=xa,yas=ya,xbs=xb,ybs=yb,swp;
        if(xas<0)xas=0;if(xas>=240)xas=239;
        if(xbs<0)xbs=0;if(xbs>=240)xbs=239;
        if(yas<0)yas=0;if(yas>=320)yas=319;
        if(ybs<0)ybs=0;if(ybs>=320)ybs=319;
        bool dir=true;
        if(xas>xbs){
            swp=xas;
            xas=xbs;
            xbs=swp;
            dir=!dir;
        }
        if(yas>ybs){
            swp=yas;
            yas=ybs;
            ybs=swp;
            dir=!dir;
        }
        //xas<=xbs yas<=ybs
        int ryas=yas-pagestarty,rybs=ybs-pagestarty;
        int rx=xas,ry=ryas;
        if(yas==ybs){   //horizontal line
            if(ry>=refreshsp&&ry<=refreshep)
                for(;rx<=xbs;rx++)
                    dispmem[240*ry+rx]=col;
        }else if(xas==xbs){ //vertical line
            for(;ry<=rybs;ry++){
                if(ry>=refreshsp&&ry<=refreshep){
                    dispmem[240*ry+rx]=col;
                }
            }
        }else if((ybs-yas)<(xbs-xas)){    //longer in x direction
            double dx=((double)(xbs-xas+1))/(ybs-yas+1);
            double xps=xas;
            if(dir)
                for(ry=ryas;ry<=rybs;ry++){
                    xps+=dx;
                    for(;rx<=(int)xps;rx++){
                        if(ry>=refreshsp&&ry<=refreshep){
                            dispmem[240*ry+rx]=col;
                        }
                    }
                }
            else
                for(ry=rybs;ry>=ryas;ry--){
                    xps+=dx;
                    for(;rx<=(int)xps;rx++){
                        if(ry>=refreshsp&&ry<=refreshep){
                            dispmem[240*ry+rx]=col;
                        }
                    }
                }
        }else{  //longer in y direction
            double dy=((double)(ybs-yas+1))/(xbs-xas+1);
            double ryps=ryas;
            if(dir)
                for(rx=xas;rx<=xbs;rx++){
                    ryps+=dy;
                    for(;ry<=(int)ryps;ry++){
                        if(ry>=refreshsp&&ry<=refreshep){
                            dispmem[240*ry+rx]=col;
                        }
                    }
                }
            else
                for(rx=xbs;rx>=xas;rx--){
                    ryps+=dy;
                    for(;ry<=(int)ryps;ry++){
                        if(ry>=refreshsp&&ry<=refreshep){
                            dispmem[240*ry+rx]=col;
                        }
                    }
                }
        }
        if(thick){
            if((ybs-yas)<(xbs-xas))
                drawline(dispmem,pagestarty,pageendy,xa,ya+1,xb,yb+1,col,refreshsp,refreshep,false);
            else
                drawline(dispmem,pagestarty,pageendy,xa+1,ya,xb+1,yb,col,refreshsp,refreshep,false);
        }
    }
};

#endif
