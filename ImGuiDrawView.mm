//Require standard library
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <Foundation/Foundation.h>
//Imgui library
#import "Esp/CaptainHook.h"
#import "Esp/ImGuiDrawView.h"
#import "IMGUI/imgui.h"
#import "IMGUI/imgui_impl_metal.h"
#import "IMGUI/zzz.h"
//Patch library
#import "5Toubun/NakanoIchika.h"
#import "5Toubun/NakanoNino.h"
#import "5Toubun/NakanoMiku.h"
#import "5Toubun/NakanoYotsuba.h"
#import "5Toubun/NakanoItsuki.h"
#import "5Toubun/dobby.h"
#import "5Toubun/il2cpp.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kScale [UIScreen mainScreen].scale
#define patch_NULL(a, b) vm(ENCRYPTOFFSET(a), strtoul(ENCRYPTHEX(b), nullptr, 0))
#define patch(a, b) vm_unity(ENCRYPTOFFSET(a), strtoul(ENCRYPTHEX(b), nullptr, 0))
#define patchanogs(a, b) vm_anogs(ENCRYPTOFFSET(a), strtoul(ENCRYPTHEX(b), nullptr, 0))


@interface ImGuiDrawView () <MTKViewDelegate>
@property (nonatomic, strong) id <MTLDevice> device;
@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;
@end

@implementation ImGuiDrawView

static bool map = true;

//Function for hacking/cheating is now up here. Example auto update right here (work on every version of this game)
void (*_ret)(void *instance);
void ret(void *instance) {
    return;
}


bool (*_ShowHeroInfo)(void *instance);
bool ShowHeroInfo(void *instance) {
    if (instance != nullptr && map) {
        return true; 
    }
    return _ShowHeroInfo(instance);
}
void (*_ShowSkillStateInfo)(void *instance, bool bShow);
void ShowSkillStateInfo(void *instance, bool bShow) {
    if (instance != nullptr && map) {
      bShow = true; 
    }
    _ShowSkillStateInfo(instance, bShow);
}

void (*_ShowHeroHpInfo)(void *instance, bool bShow);
void ShowHeroHpInfo(void *instance, bool bShow) {
    if (instance != nullptr && map) {
      bShow = true;
    }
    _ShowHeroHpInfo(instance, bShow);
}

bool (*_IsHostProfile)(void *instance);
bool IsHostProfile(void *instance) {
    if (instance != nullptr) {
    return true;
}
return _IsHostProfile(instance);
}

float SetFieldOfView = 2.0;
float(*cam)(void* _this);
float _cam(void* _this){
return SetFieldOfView;{
return cam(_this);}
}

void (*highrate)(void *instance);
void _highrate(void *instance)
{
    highrate(instance);
}
static bool lockcam = false;
void (*Update)(void *instance);
void _Update(void *instance)
{
    if(instance!=NULL){
        _highrate(instance);
    }
    if(lockcam){
        return;
    }
    return Update(instance);
}

void (*_LActorRoot_Visible)(void *instance, int camp, bool bVisible, const bool forceSync);
void LActorRoot_Visible(void *instance, int camp, bool bVisible, const bool forceSync = false) {
    if (instance != nullptr && map) {
        if(camp == 1 || camp == 2 || camp == 110 || camp == 255) {
            bVisible = true;
        }
    } 
 return _LActorRoot_Visible(instance, camp, bVisible, forceSync);
}

static bool antia = false;
bool (*_IsSkillDirControlRotate)(void *instance, int skillSlotType);
bool IsSkillDirControlRotate(void *instance, int skillSlotType) {
    if (instance != NULL) {
        if (antia) return false;
    }
    return _IsSkillDirControlRotate(instance, skillSlotType); 
}

static bool buffno = false;
void (*_SetHpAndEpToInitialValue)(void *player, int hpPercent, int epPercent);
void SetHpAndEpToInitialValue(void *player, int hpPercent, int epPercent) {
    if (player != NULL && buffno) {
        hpPercent = -999999;
        epPercent = -999999;
    }
    _SetHpAndEpToInitialValue(player, hpPercent, epPercent);
}


bool AimSkill;
int Radius = 25;
bool AutoTrung;
int skillSlot;
bool aimSkill1;
bool aimSkill2;
bool aimSkill3;
bool (*_IsSmartUse)(void *instance);
bool (*_get_IsUseCameraMoveWithIndicator)(void *instance);

bool IsSmartUse(void *instance){
    
    bool aim = false;
    
    if(skillSlot == 1 && aimSkill1){
        aim = true;
    }
    
    if(skillSlot == 2 && aimSkill2){
        aim = true;
    }
    
    if(skillSlot == 3 && aimSkill3){
        aim = true;
    }
    
    if(AutoTrung && aim){
        return true;
    }
    
    return _IsSmartUse(instance);
}

bool get_IsUseCameraMoveWithIndicator(void *instance){
    
    bool aim = false;
    
    if(skillSlot == 1 && aimSkill1){
        aim = true;
    }
    
    if(skillSlot == 2 && aimSkill2){
        aim = true;
    }
    
    if(skillSlot == 3 && aimSkill3){
        aim = true;
    }
    
    
    if(AutoTrung && aim){
        return true;
    }
    
    return _get_IsUseCameraMoveWithIndicator(instance);
}
void (*old_IsDistanceLowerEqualAsAttacker)(void *instance, int targetActor, int radius);
void IsDistanceLowerEqualAsAttacker(void *instance, int targetActor, int radius) {
    
    bool aim = false;
    
    if(skillSlot == 1 && aimSkill1){
        aim = true;
    }
    
    if(skillSlot == 2 && aimSkill2){
        aim = true;
    }
    
    if(skillSlot == 3 && aimSkill3){
        aim = true;
    }
    
    
    if (instance != NULL && AimSkill && aim) {
        radius = Radius * 1000;
    }
    old_IsDistanceLowerEqualAsAttacker(instance, targetActor, radius);
}
bool (*_IsUseSkillJoystick)(void *instance, int slot);
bool IsUseSkillJoystick(void *instance, int slot){
    skillSlot = slot;
    return _IsUseSkillJoystick(instance, slot);
}

uint64_t hackmap;
uint64_t heroinfo;
uint64_t skillinfo;
uint64_t hpinfo;



uint64_t hideuid;
uint64_t HistoryOffset;

uint64_t SkillControlOffset;

uint64_t CamOffset;
uint64_t UpdateOffset;
uint64_t HighrateOffset;

uint64_t sethp;

uint64_t IsSmartUseOffset;
uint64_t CameraMoveOffset;
uint64_t DistanceOffset;
uint64_t JoystickOffset;

uint64_t updateframelateroffset;

void initial_setup(){
    //Auto update using ByNameModding for il2cpp
    Il2CppAttach();

    Il2CppMethod& getClass(const char* namespaze, const char* className);
    uint64_t getMethod(const char* methodName, int argsCount);

    Il2CppMethod methodAccess("Project.Plugins_d.dll");
    hackmap = methodAccess.getClass("NucleusDrive.Logic", "LVActorLinker").getMethod("SetVisible", 3);

    sethp = methodAccess.getClass("NucleusDrive.Logic", "ValuePropertyComponent").getMethod("SetHpAndEpToInitialValue", 2);

    updateframelateroffset = methodAccess.getClass("NucleusDrive.Logic", "LFrameSynchr").getMethod("UpdateFrameLater", 0);

    Il2CppMethod methodAccess2("Project_d.dll");

    heroinfo = methodAccess2.getClass("Assets.Scripts.GameSystem", "HeroInfoPanel").getMethod("ShowHeroInfo", 2);
    skillinfo = methodAccess2.getClass("", "MiniMapHeroInfo").getMethod("ShowSkillStateInfo", 1);
    hpinfo = methodAccess2.getClass("", "MiniMapHeroInfo").getMethod("ShowHeroHpInfo", 1);

    hideuid = methodAccess2.getClass("Assets.Scripts.GameSystem", "CLobbySystem").getMethod("OpenWaterMark", 0);
    HistoryOffset = methodAccess2.getClass("Assets.Scripts.GameSystem", "CPlayerProfile").getMethod("get_IsHostProfile", 0);

    SkillControlOffset = methodAccess2.getClass("Assets.Scripts.GameSystem", "CSkillButtonManager").getMethod("IsSkillDirControlRotate", 1);
    CamOffset = methodAccess2.getClass("", "CameraSystem").getMethod("GetCameraHeightRateValue", 1);
    UpdateOffset = methodAccess2.getClass("", "CameraSystem").getMethod("Update", 0);
    HighrateOffset = methodAccess2.getClass("", "CameraSystem").getMethod("OnCameraHeightChanged", 0);

    IsSmartUseOffset = methodAccess2.getClass("Assets.Scripts.GameLogic", "GameInput").getMethod("IsSmartUse", 0);
    CameraMoveOffset = methodAccess2.getClass("Assets.Scripts.GameLogic", "Skill").getMethod("get_IsUseCameraMoveWithIndicator", 0);
    DistanceOffset = methodAccess2.getClass("Kyrios.Actor", "ObjLinkerWrapper").getMethod("IsDistanceLowerEqualAsAttacker", 2);
    JoystickOffset = methodAccess2.getClass("Assets.Scripts.GameLogic", "SkillComponent").getMethod("IsUseSkillJoystick", 1);

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DobbyHook((void *)getRealOffset(hackmap), (void *)LActorRoot_Visible, (void **)&_LActorRoot_Visible);
        DobbyHook((void *)getRealOffset(heroinfo), (void *)ShowHeroInfo, (void **)&_ShowHeroInfo);
        DobbyHook((void *)getRealOffset(skillinfo), (void *)ShowSkillStateInfo, (void **)&_ShowSkillStateInfo);
        DobbyHook((void *)getRealOffset(hpinfo), (void *)ShowHeroHpInfo, (void **)&_ShowHeroHpInfo);

        DobbyHook((void *)getRealOffset(HistoryOffset), (void *)IsHostProfile, (void **)&_IsHostProfile);
        DobbyHook((void *)getRealOffset(hideuid), (void *)ret, (void **)&_ret);
        DobbyHook((void *)getRealOffset(SkillControlOffset), (void *)IsSkillDirControlRotate, (void **)&_IsSkillDirControlRotate);
    
        DobbyHook((void *)getRealOffset(CamOffset), (void *)_cam, (void **)&cam);
        DobbyHook((void *)getRealOffset(UpdateOffset), (void *)_Update, (void **)&Update);
        DobbyHook((void *)getRealOffset(HighrateOffset), (void *)_highrate, (void **)&highrate);

        DobbyHook((void *)getRealOffset(sethp), (void *)SetHpAndEpToInitialValue, (void **)&_SetHpAndEpToInitialValue);

        DobbyHook((void *)getRealOffset(IsSmartUseOffset), (void *)IsSmartUse, (void **)&_IsSmartUse);
        DobbyHook((void *)getRealOffset(CameraMoveOffset), (void *)get_IsUseCameraMoveWithIndicator, (void **)&_get_IsUseCameraMoveWithIndicator);
        DobbyHook((void *)getRealOffset(DistanceOffset), (void *)IsDistanceLowerEqualAsAttacker, (void **)&old_IsDistanceLowerEqualAsAttacker);
        DobbyHook((void *)getRealOffset(JoystickOffset), (void *)IsUseSkillJoystick, (void **)&_IsUseSkillJoystick);
        //anti unity
        DobbyHook((void *)getRealOffset(updateframelateroffset), (void *)ret, (void **)&_ret);
    });
}

static bool MenDeal = true;


- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    _device = MTLCreateSystemDefaultDevice();
    _commandQueue = [_device newCommandQueue];

    if (!self.device) abort();

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;

    ImGui::StyleColorsClassic();
    
    ImFont* font = io.Fonts->AddFontFromMemoryCompressedTTF((void*)zzz_compressed_data, zzz_compressed_size, 60.0f, NULL, io.Fonts->GetGlyphRangesVietnamese());
    
    ImGui_ImplMetal_Init(_device);

    return self;
}

+ (void)showChange:(BOOL)open
{
    MenDeal = open;
}

- (MTKView *)mtkView
{
    return (MTKView *)self.view;
}

- (void)loadView
{

 

    CGFloat w = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width;
    CGFloat h = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height;
    self.view = [[MTKView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //patch anti anogs
    patchanogs("0x9AD1C", "0xC0035FD6");

    initial_setup();

    self.mtkView.device = self.device;
    self.mtkView.delegate = self;
    self.mtkView.clearColor = MTLClearColorMake(0, 0, 0, 0);
    self.mtkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.mtkView.clipsToBounds = YES;

}



#pragma mark - Interaction

- (void)updateIOWithTouchEvent:(UIEvent *)event
{
    UITouch *anyTouch = event.allTouches.anyObject;
    CGPoint touchLocation = [anyTouch locationInView:self.view];
    ImGuiIO &io = ImGui::GetIO();
    io.MousePos = ImVec2(touchLocation.x, touchLocation.y);

    BOOL hasActiveTouch = NO;
    for (UITouch *touch in event.allTouches)
    {
        if (touch.phase != UITouchPhaseEnded && touch.phase != UITouchPhaseCancelled)
        {
            hasActiveTouch = YES;
            break;
        }
    }
    io.MouseDown[0] = hasActiveTouch;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

#pragma mark - MTKViewDelegate
#define iPhonePlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
- (void)drawInMTKView:(MTKView*)view
{
   
    
   ImGuiIO& io = ImGui::GetIO();
    io.DisplaySize.x = view.bounds.size.width;
    io.DisplaySize.y = view.bounds.size.height;
    CGFloat framebufferScale = view.window.screen.scale ?: UIScreen.mainScreen.scale;
    if (iPhonePlus) {
        io.DisplayFramebufferScale = ImVec2(2.60, 2.60);
    }else{
        io.DisplayFramebufferScale = ImVec2(framebufferScale, framebufferScale);
    }
    io.DeltaTime = 1 / float(view.preferredFramesPerSecond ?: 120);
    
    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
    

//Define your bool/function in here
    static bool show_s0 = false;    
    static bool show_s1 = false;    
    static bool show_s2 = false;    
    static bool show_s3 = false;    
    static bool show_s4 = false;    
    static bool show_s5 = false;    
    static bool show_s6 = false;                    
    static bool show_s7 = false;        
    static bool show_s8 = false;      
    static bool show_s9 = false;     
    static bool show_s10 = false;     
    static bool show_s11 = false;     
    static bool show_s12 = false;   

//Define active function
    static bool show_s0_active = false;
    static bool show_s1_active = false;
    
        
        if (MenDeal == true) {
            [self.view setUserInteractionEnabled:YES];
        } else if (MenDeal == false) {
            [self.view setUserInteractionEnabled:NO];
        }

        MTLRenderPassDescriptor* renderPassDescriptor = view.currentRenderPassDescriptor;
        if (renderPassDescriptor != nil)
        {
            id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
            [renderEncoder pushDebugGroup:@"ImGui Jane"];

            ImGui_ImplMetal_NewFrame(renderPassDescriptor);
            ImGui::NewFrame();
            
            ImFont* font = ImGui::GetFont();
            font->Scale = 19.f / font->FontSize;
            
            CGFloat x = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width) - 360) / 2;
            CGFloat y = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height) - 300) / 2;
            
            ImGui::SetNextWindowPos(ImVec2(x, y), ImGuiCond_FirstUseEver);
            ImGui::SetNextWindowSize(ImVec2(450, 300), ImGuiCond_FirstUseEver);
            
            if (MenDeal == true)
            {                
                ImGui::Begin("Sylphin3107 AOV Menu Hack!", &MenDeal);     
                ImGui::Text("Dùng 3 Ngón Tay Chạm Màn Hình 2 Lần Mở Menu");
                ImGui::TableNextColumn();
                ImGui::Text("Dùng 2 Ngón Tay Chạm Màn Hình 2 Lần Tắt Menu");
                ImGui::TableNextColumn();
                ImGui::Separator();
                ImGui::Checkbox("Bật Hack Map", &map);
                ImGui::SameLine();
                ImGui::Checkbox("Ẩn Tia Elsu", &antia);
                ImGui::SameLine();
                ImGui::Checkbox("Buff Nổ", &buffno);
                ImGui::TableNextColumn();
                ImGui::Separator();
                ImGui::Checkbox("Khóa Camera", &lockcam);
                ImGui::TableNextColumn();
                ImGui::SliderFloat("Độ Cao Camera", &SetFieldOfView, 1, 4);
                ImGui::TableNextColumn();
                ImGui::Separator();
                ImGui::Checkbox(" Aim ", &AimSkill);
                ImGui::Checkbox("Chiêu 1",&aimSkill1);
                ImGui::SameLine();
                ImGui::Checkbox("Chiêu 2",&aimSkill2);
                ImGui::SameLine();
                ImGui::Checkbox("Chiêu 3",&aimSkill3);
                ImGui::Text("Phạm Vi");
                ImGui::SameLine();
                ImGui::SliderInt( "##1", &Radius, 20, 30, "%dm" );
                ImGui::Checkbox("Tự Động Tìm Mục Tiêu (Mở Kèm Aim)", &AutoTrung);
                ImGui::End();

                
                
            }
            ImDrawList* draw_list = ImGui::GetBackgroundDrawList();

            ImGuiStyle& style = ImGui::GetStyle();
            ImVec4* colors = style.Colors;
            style.WindowRounding = 10.000f;
            style.WindowTitleAlign = ImVec2(0.490f, 0.520f);
            style.ChildRounding = 6.000f;
            style.PopupRounding = 6.000f;
            style.FrameRounding = 6.000f;
            style.FrameBorderSize = 1.000f;
            style.GrabRounding = 12.000f;
            style.TabRounding = 7.000f;
            style.ButtonTextAlign = ImVec2(0.510f, 0.490f);
            style.Alpha = 0.9f;



            if(show_s1){
                if(show_s1_active == NO){
                    //patch("", "0x");
                    }
                show_s1_active = YES;
            }
            else{
                if(show_s1_active == YES){
                    //patch("", "0x");
                    }
                show_s1_active = NO;
            }


            ImGui::Render();
            ImDrawData* draw_data = ImGui::GetDrawData();
            ImGui_ImplMetal_RenderDrawData(draw_data, commandBuffer, renderEncoder);
          
            [renderEncoder popDebugGroup];
            [renderEncoder endEncoding];

            [commandBuffer presentDrawable:view.currentDrawable];
        }

        [commandBuffer commit];
}

- (void)mtkView:(MTKView*)view drawableSizeWillChange:(CGSize)size
{
    
}

@end

