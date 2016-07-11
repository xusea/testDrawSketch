//
//  opencvproxy.cpp
//  testDrawSketch
//
//  Created by xusea on 16/6/2.
//  Copyright © 2016年 xusea. All rights reserved.
//

#include "opencvproxy.hpp"

void FillInternalContours(IplImage *pBinary, double dAreaThre)
{
    double dConArea;
    CvSeq *pContour = NULL;
    CvSeq *pConInner = NULL;
    CvMemStorage *pStorage = NULL;
    // 执行条件
    if (pBinary)
    {
        // 查找所有轮廓
        pStorage = cvCreateMemStorage(0);
        cvFindContours(pBinary, pStorage, &pContour, sizeof(CvContour), CV_RETR_CCOMP, CV_CHAIN_APPROX_SIMPLE);
        // 填充所有轮廓
        cvDrawContours(pBinary, pContour, CV_RGB(255, 255, 255), CV_RGB(255, 255, 255), 2, CV_FILLED, 8, cvPoint(0, 0));
        // 外轮廓循环
        for (; pContour != NULL; pContour = pContour->h_next)
        {
            // 内轮廓循环
            for (pConInner = pContour->v_next; pConInner != NULL; pConInner = pConInner->h_next)
            {
                // 内轮廓面积
                dConArea = fabs(cvContourArea(pConInner, CV_WHOLE_SEQ));
                if (dConArea <= dAreaThre)
                {
                    cvDrawContours(pBinary, pConInner, CV_RGB(255, 255, 255), CV_RGB(255, 255, 255), 0, CV_FILLED, 8, cvPoint(0, 0));
                }
            }
        }
        cvReleaseMemStorage(&pStorage);
        pStorage = NULL;
    }
}

void opencvproxy_imagecut(char * imagein, char * imageout , char *imagelog)
{
    std::string imgNameW = imagein;
    std::string gtImgW = imageout;
    std::string salDir = imagelog;
    try{
        CmSalCut::Demo(imgNameW, gtImgW, salDir);
    }
    catch(...)
    {
    
    }
}

void opencvproxy_fillcontour(char * infile, char * outfile)
{
    IplImage *img = cvLoadImage(infile, 0);
    IplImage *bin = cvCreateImage(cvGetSize(img), IPL_DEPTH_8U, 1);
    cvCopy(img, bin);
    
    FillInternalContours(bin, 20000);
    cvSaveImage(outfile, bin);
}

double opencvproxy_com2image(char * leftfile, char * rightfile)
{
    IplImage *mode = cvLoadImage(leftfile, 1);
    IplImage *test = cvLoadImage(rightfile, 1);
    if(mode == NULL || test == NULL)
    {
        return -1.0;
    }
    IplImage* bw_mode = cvCreateImage(cvGetSize(mode), mode->depth, 1);
    IplImage* bw_test = cvCreateImage(cvGetSize(test), mode->depth, 1);
    
    cvCvtColor(mode, bw_mode, CV_RGB2GRAY);
    cvCvtColor(test, bw_test, CV_RGB2GRAY);
    
    double matching = cvMatchShapes(bw_test, bw_mode, 3);

    return matching;
}