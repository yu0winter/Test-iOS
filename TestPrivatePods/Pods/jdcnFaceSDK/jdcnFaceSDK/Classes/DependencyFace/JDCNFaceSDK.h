#ifndef JDCN_FACE_SDK_H
#define JDCN_FACE_SDK_H

#include <string>
#include <vector>
#include "JDCNBaseStruct.h"

using namespace std;

namespace jdcn
{

    namespace face
    {

        typedef struct Rect
        {
            int   x0;     
            int   y0;     
            int   width;  
            int   height; 

            //methods
            bool isZero();
            static Rect RectZero();
            static Rect RectMake(int x, int y, int width, int height);
            static bool RectContains(Rect outter, Rect inner, float frameOutOverlap);
        } Rect;

        typedef struct CNMat
        {
            unsigned char * data;
            int width;
            int height;
            int channel;

            CNMat() : data(NULL), width(0), height(0), channel(0) {}
            CNMat Copy();
            CNMat CropByRect(Rect rect);
            bool Empty();
            void Release();
        } CNMat;

        typedef struct FaceConfig
        {
            int                         flagMutipleFace;        ///<0-单人脸，1-多人脸, 默认为0
            int                         flagForceRefine;        ///<是否为refine模式，设置为1会导致计算量增加，但是跟踪结果会更加稳定，默认为0
            int                         flagRotate;             ///<旋转模式，0-7，八种, 0，1为竖屏模式，2，3为横屏模式，4-7为预留

            float                       faceBoundCenterX;       ///<可识别区域中心X比例坐标，范围（0～1），0.5为camera中心，默认为0.5
            float                       faceBoundCenterY;       ///<可识别区域中心X比例坐标，范围（0～1），0.5为camera中心，默认为0.5
            float                       faceBoundWidth;         ///<可识别区域的宽度比例，范围（0～1），1为camera的整个宽度，默认为1
            float                       faceBoundHeight;        ///<可识别区域的高度比例，范围（0～1），1为camera的整个高度，默认为1

            int                         faceMaxArea;            ///<允许识别的最大人脸面积，为1000*1000的时候对于现有设备几乎没有限制，默认为1000*1000
            int                         faceMinArea;            ///<允许识别的最小人脸面积，为0的时候没有限制，默认为0

            int                         faceSnapshotTimes;      ///<人脸选帧的帧数上限，单人脸建议值为6，代表最多6帧内必选一帧，如果少于6帧就已找到合格帧则提前选帧成功，多人脸建议值为3, 可根据运行硬件平台的处理速度和业务需求进行调整，比如注册时可适当调大，默认为6
            int                         continueStaticTimes;    ///<人脸连续静止选帧，默认为2，注册时建议为3
            float                       angleUp;                ///<头部仰角，默认为12，注册时建议为10
            float                       angleDown;              ///<头部俯角，默认为-12，注册时建议为-10
            float                       angleLeft;              ///<头部左偏角，默认为12，注册时建议为10
            float                       angleRight;             ///<头部右偏角，默认为-12，注册时建议为-10
            float                       overlapArea1;           ///<人脸重合度阈值，配合头部偏角使用，默认为0.8
            float                       overlapArea2;           ///<人脸重合度阈值，记录快照使用，默认为0.9

            float                       faceImgScale;           ///<人脸截图尺度，默认为2，该图越大，所截取的人脸图越大
            
            JDCNLiveMode                liveMode;               ///<识别模式：静默，活体，静默+活体，默认为静默
            std::vector<JDCNActionType> actions;                ///<活体检测动作序列

            int                         imageType;              ///<输入图像类型，安卓: 0-nv21, 1-RGB(888), 2-nv12; IOS: 0-BGRA(8888). 1-RGBA(8888) 默认均为0
            int                         outputRotate;           ///<输出图像旋转类型, 安卓: 0-输出旋转90度，1-输出正常图像; IOS: 0-输出旋转90度，默认均为0（因历史SDK边界划分原因，安卓一直直接输出旋转90度的选帧结果，在JNI层再旋转过来，安卓没有效率高的系统函数来实现旋转，为了提升效率，同时兼容老的安卓SDK，所以添加了本参数）
            int                         flagBlinkDetect;        ///<静默模式是否进行闭眼检测，0-不进行闭眼检测，检测速度快，1-进行闭眼检测，双目防伪建议开启，默认为0

            int                         detectFaceSize;         ///<可检测人脸的尺度参数，值越大，召回率越高，速度越慢，设置为0或负数时，会设置为init传入的参数，默认为0
            float                       frameOutOverlap;        ///<判断是否出框的重合度阈值（0～1.0之间），越大越严格，默认值为0.8

            int                         flagLog;                ///<log信息开关
            //methods
            FaceConfig();
            void reset();
            FaceConfig copy();
        } FaceConfig;

        //选帧统计信息，从DetectResume开始统计的帧数，选帧成功后不再进行更新, DetectResume清零
        typedef struct FrameInfo
        {
            int             frame_num;                          ///<当前已处理的帧数
            int             find_face;                          ///<已找到人脸的帧数
            int             frame_out;                          ///<判断为出框的帧数
            int             frame_far;                          ///<判断为太远的帧数
            int             frame_near;                         ///<判断为太近的帧数
            int             frame_blink;                        ///<判断为闭眼的帧数
            int             frame_pose;                         ///<姿态不正确的帧数
            int             frame_blur;                         ///<判断为模糊的帧数
        }FrameInfo;

        typedef struct FaceInfo
        {
            int             landmarks[kJDCNLandmarkCount*2];    ///<关键点坐标
            Rect            faceRect;                           ///<人脸坐标区域
            unsigned long   face_id;                            ///<人脸ID
        }FaceInfo;

        typedef struct FaceDataInfo
        {
            jdcn::face::CNMat face_img;                         ///<人脸图像, 安卓-RGB888格式, IOS-ABGR
            jdcn::face::CNMat preview_img;                      ///<预览图像, 安卓-RGB888格式, IOS-ABGR
            std::vector<float> face_info;                       ///<人脸信息
            unsigned long face_id;                              ///<人脸ID
        }FaceDataInfo;

        /**
        *  @brief  回调函数
        *  @param  type             回调类型
        *  @param  data             返回图像数据，RGB888格式，返回数据是否旋转根据FaceConfig::outputRotate设置，返回数据内容根据FaceConfig::liveMode设置
        *  @param  actType          当前正在检测的动作活体类型
        *  @param  faceDataInfo     人脸信息
        *  @return 0为成功，否则为失败 
        */
        typedef void (* FaceCallBack)(JDCNCallBackType type, std::vector<CNMat> data, JDCNActionType actType, std::vector<FaceDataInfo> facesInfo);

        class FaceManager
        {

        public:
        
            /**
             *  @brief  初始化函数
             *          此函数耗时较长，仅需调用一次
             *  @param  size            （输入）可检测人脸的尺度参数，值越大，召回率越高，速度越慢，本参数仅为兼容旧SDK留存，建议在FaceConfig::detectFaceSize进行设置
             *  @param  ws_root         （输入）在使用外部模型资源时的资源文件路径，如果不使用外部模型资源，则该参数无效    
             *  @param  faceCallBack    （输入）回调函数
             *  @return 0为成功，否则为失败 
             */
            int Init(int size, std::string ws_root, FaceCallBack faceCallBack);

            /**
             *  @brief  释放资源函数
             *  @return 无返回 
             */
            void Release();

            /**
             *  @brief  设置SDK参数
             *          目前该接口不支持在调用DetectFaceFrame时同时动态修改参数
             *  @param  cfg             （输入）SDK配置参数
             *  @return 无返回 
             */
            void SetLiveConfig(FaceConfig cfg);

            /**
             *  @brief  对每帧图像进行人脸检测
             *          目前该接口不支持多线程调用
             *  @param  data            （输入）输入相机的数据（安卓支持NV21数据，IOS支持4通道数据）
             *  @param  width           （输入）图像宽
             *  @param  height          （输入）图像高
             *  @param  facesInfo       （输出）检测到人脸的信息，包括人脸框和关键点
             *  @return 无返回
             */
            void DetectFaceFrame(unsigned char *data, int width, int height, std::vector <FaceInfo> &facesInfo);

            /**
             *  @brief  检测重置
             *          每次识别之前需要调用该接口进行检测重置
             *  @return 无返回 
             */
            void DetectResume();

            /**
             *  @brief  获取SDK版本信息（SDK版本，模型版本，最近变更）
             *  @return SDK版本信息
             */
            std::string GetSDKInfo();

            /**
             *  @brief  获取选帧状态，从DetectResume开始统计，选帧成功后不再进行更新, DetectResume清零
             *  @return 选帧状态Jason结果
             */
            FrameInfo GetFrameInfo();
        private:

            void *faceManagerCore;
        };

    }
}

#endif