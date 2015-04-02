
//Remotion c4d for D module >>>

module c4d_os;

import c4d;
public import c4d_prepass;
public import c4d_string;

import std.c.stdio : printf; //printf

//do we really need public here !?

public import c4d_quaternion;

public import c4d_filename;
public import c4d_gedata;
public import c4d_basecontainer;
public import c4d_vector;
public import c4d_basetime;
public import c4d_file;

public import c4d_basebitmap;


import c4d_general : Registry;

import c4d_nodedata : NodeData,  NODEPLUGIN;
import lib_description : DescID,Description,DynamicDescription;

//public import c4d_baselist; 
public import c4d_baselist : C4DAtom,C4DAtomGoal,GeListNode,BaseList2D;

public import c4d_basetag;// : BaseTag;
public import c4d_basedocument;// : BaseDocument;
public import c4d_baseobject;// : BaseObject;

public import c4d_basedraw;

/// x64 ABI
// http://msdn.microsoft.com/en-us/library/7572ztz4.aspx

//"Windows x64 calling convention."

//return value
//A return value that can fit into 8 bytes is returned through RAX!
//If return value is user-defined type and is bigger as 8 bytes will be returned as first argument.
//For member function return value if the second argumend after this pointer !


//struct Matrix; //TODO 
/+
struct Matrix64
{
	Vector64 off, v1, v2, v3;
}
struct Matrix32
{
	Vector32 off, v1, v2, v3;
}

alias Matrix64 Matrix;

struct Matrix4d; 
+/

struct C4DUuid;

//static if(1){
//struct C4DAtom;
//struct C4DAtomGoal;
struct AtomArray;
//struct NodeData;
//struct GeListNode;
struct GeListHead;
struct GeMarker;
struct AliasTrans;
//struct Registry;
struct CDialog;
struct CUserArea;
struct _GeListView;
struct _SimpleListView;
//struct BaseTag;
struct MPBaseThread;
struct Semaphore;
struct VariableTag;
//struct BaseTime;
struct BaseChannel;
//struct BaseContainer;
//struct BaseDocument;
struct BaseSelect;
struct HyperFile;
struct MemoryFileStruct;
//struct BaseList2D;
//struct BaseObject;
struct SplineObject;
struct GeSignal;
struct BaseShader;
struct PointObject;
struct PolygonObject;
struct LineObject;
struct MultipassObject;
//struct BaseDraw;
//struct BaseDrawHelp;
//struct BaseView;
struct BaseLink;
//struct BaseBitmap;
struct MemoryPool;
struct BaseMaterial;
struct Material;
struct BaseVideoPost;
struct RenderData;
struct LocalFileTime;
struct Render;
struct TextureTag;
struct MovieSaver;
struct IpConnection;
struct BrowseFiles;
struct BrowseVolumes;
struct Parser;
//struct BaseFile;
struct AESFile;
struct SelectionTag;
struct LassoSelection;
struct UVWTag;
struct ObjectSafety;
struct BaseSceneHook;
struct ParticleTag;
struct StickTextureTag;
struct Particle;
struct LocalResource;
struct HierarchyHelp;
struct FolderSequence;
struct SoundSequence;
struct BaseSound;
struct Stratified2DRandom;
struct BaseThread;
struct EnumerateEdges;
struct PaintTexture;
struct PaintLayer;
struct PaintLayerBmp;
struct SDKBrowserURL;
struct PaintLayerMask;
struct PaintLayerFolder;
struct PaintBitmap;
struct PaintMaterial;
struct LayerSet;
struct EditorWindow;
struct VPBuffer;
//struct GeData;
//struct Description;
//struct DescID;
//struct DynamicDescription;
//struct Filename;
struct BasePlugin;
struct PriorityList;
struct LensGlowStruct;
struct CBaseFrame;
struct PolyTriangulate;
struct ViewportSelect;
struct Pgon;
struct NgonBase;
//struct MultipassBitmap;
struct Coffee;
struct VALUE;
struct CKey;
struct CCurve;
struct CTrack;
struct GeClipMap;
struct CAnimInfo;
struct GlString;
struct Gradient;
struct GlProgramFactory;
struct GlFrameBuffer;
struct GlVertexBuffer;
struct LayerObject;
struct C4DObjectList;
struct LayerSetHelper;
struct BaseBitmapLink;
struct BitmapLoaderPlugin;
struct ColorProfile;
struct ColorProfileConvert;
struct SplineLengthData;
struct UnitScaleData;
struct ParserCache;
struct GlVertexBufferAttributeInfo;
struct GlVertexBufferVectorInfo;
struct SurfaceDataEx;
struct RayIllumination;
struct NetRenderService;


//struct in c++
struct RayShaderStackElement;
struct AssetData;
struct LayerData;
//struct CustomDataType;
struct ParticleDetails;
struct PolyInfo;
struct IlluminanceSurfacePointData;
struct SDataEx;
struct VolumeData;
struct Ray;
struct Tangent;
//struct UVWStruct;
struct Segment;
struct TexList;
struct CPolygon;
struct RayHitID;
struct InitRenderStruct;
struct RayObject;
struct RayLight;
struct RaySampler;
struct RayHemiSample;
struct RayHemisphere;
struct RayRadianceObject;
struct PolyVector;
struct TexData;
struct VideoPostStruct;
struct SurfaceData;
struct RayPolyWeight;
struct MouseDownInfo;
struct DrawInfo;
struct RayLightCache;
//struct IconData;
struct C4D_GraphView;
//struct NODEPLUGIN;
struct VPFragment;
struct BranchInfo;
struct AnimValue;
struct ObjectColorProperties;
struct PixelFragment;
struct ChannelData;
struct CUSTOMDATATYPEPLUGIN;
struct RESOURCEDATATYPEPLUGIN;
struct TempUVHandle;
struct TextureSize;
struct ViewportPixel;
struct NgonNeighbor;
struct SurfaceIntersection;
struct ARRAY;
struct OBJECT;
struct CSTRING;
struct CLASS;
//struct C4DPL_CommandLineArgs;
struct BakeProgressInfo;
struct GlLight;
struct GlGetIdentity;
struct OITInfo;
struct BitmapRenderRegion;
struct GeRWSpinlock;
struct GeSpinlock;
struct PickSessionDataStruct;
struct StereoCameraInfo;
//class GlVertexSubBufferData;
struct VertexSubBufferData;
struct GlVertexBufferDrawSubbuffer;
struct GlFBAdditionalTextureInfo;
struct GlTextureInfo;
struct BaseSelectData;
struct C4D_BitmapFilter;
struct GlReadDescriptionData;
struct GlWriteDescriptionData;
struct DisplaceInfo;

struct CustomDataType
{
};

struct C4DPL_CommandLineArgs
{
	Int32				argc;
	char**				argv;
	Int32				argc_w;	// only available on Windows - unicode encoding of the parameters
	UInt16**			argv_w;
	const char*			orig;
	const UInt16*		orig_w;
};


//extern (C)
//alias Int32 CDialogMessage(CDialog *cd, CUserArea *cu, BaseContainer *msg); //TEST

//dlang.org/cpp_interface.html
extern (C++) 
{

///class in c++ 

// function prototypes

alias Int32 CDialogMessage(CDialog *cd, CUserArea *cu, BaseContainer *msg);
alias void ListViewCallBack(ref Int32  res_type,ref void * result,void *userdata,void *secret,Int32 cmd,Int32 line,Int32 col,void *data1);
alias void IlluminationModel(VolumeData *sd, RayLightCache *rlc, void *dat);
alias Bool COFFEE_ERRORHANDLER(void *priv_data, ref const BaseContainer  bc);

//TODO >>>
/+
alias void* (*GlProgramFactoryAllocPrivate)		();
alias void  (*GlProgramFactoryFreePrivate)		(void * pData);
alias void* (*GlProgramFactoryAllocDescription)	();
alias void  (*GlProgramFactoryFreeDescription)	(void * pData);
alias Bool  (*GlProgramFactoryReadDescription)	(GlReadDescriptionData* pFile, void * pData);
alias Bool  (*GlProgramFactoryWriteDescription)	(GlWriteDescriptionData* pFile, const(void) * pData);
alias void  (*GlProgramFactoryCreateTextureFunctionCallback)	(const Float* prIn, Float* prOut, void * pData);
alias void  (*GlProgramFactoryMessageCallback)	(Int32 lMessage, const(void) * pObj, UInt64 ulIndex, GlProgramFactory* pFactory);
//alias Int32 (*GlProgramFactoryErrorHandler)(GlProgramType type, const(char) * pszError);
alias void  (*GlVertexBufferDrawElementCallback)	(Int32 lElement, void * pData);
alias void  (*BrowserPopupCallback)	(void *userdata, Int32 cmd, ref SDKBrowserURL  url);
alias Bool  (*BaseDrawMessageHook)	(BaseDraw* pBaseDraw, BaseDocument* pDoc, BASEDRAW_HOOK_MESSAGE msg, void * pData);
alias ZEROCONFACTION (*ZeroConfBrowserCallback)	(ref const String  serviceName, Int32 lInterface, ZEROCONFMACHINESTATE state, Bool moreComing, ZEROCONFERROR error, void *context);
alias void  (*ZeroConfBrowserResolvedCallback)	(ref const String  serviceName, ref const String  fullyQualifiedDomainName, Int port, Int32 lInterface, Bool txtRecordUpdate, const String* keys, const String* values, Int32 count, ZEROCONFERROR error, void * context);
+/

//alias CalculationFunc = int function(char, double);

alias GlProgramFactoryAllocPrivate  = void* function()  ;
alias GlProgramFactoryFreePrivate  = void  function(void * pData)  ;
alias GlProgramFactoryAllocDescription = void* function()  ;
alias GlProgramFactoryFreeDescription  = void  function(void * pData);
alias GlProgramFactoryReadDescription  = Bool  function(GlReadDescriptionData* pFile, void * pData)  ;
alias GlProgramFactoryWriteDescription  = Bool  function(GlWriteDescriptionData* pFile, const(void) * pData)  ;
alias GlProgramFactoryCreateTextureFunctionCallback = void  function(const Float* prIn, Float* prOut, void * pData)  ;
alias GlProgramFactoryMessageCallback = void  function(Int32 lMessage, const(void) * pObj, UInt64 ulIndex, GlProgramFactory* pFactory)  ;
//alias GlProgramFactoryErrorHandler  = Int32 function(GlProgramType type, const(char) * pszError)  ;
alias GlVertexBufferDrawElementCallback = void  function(Int32 lElement, void * pData)  ;
alias BrowserPopupCallback  = void  function(void *userdata, Int32 cmd, ref SDKBrowserURL  url)  ;
alias BaseDrawMessageHook = Bool  function(BaseDraw* pBaseDraw, BaseDocument* pDoc, BASEDRAW_HOOK_MESSAGE msg, void * pData)  ;
alias ZeroConfBrowserCallback = ZEROCONFACTION function( ref const String   serviceName, Int32 lInterface, ZEROCONFMACHINESTATE state, Bool moreComing, ZEROCONFERROR error, void *context)  ;
alias ZeroConfBrowserResolvedCallback = void  function( ref const String   serviceName, ref const String   fullyQualifiedDomainName, Int port, Int32 lInterface, Bool txtRecordUpdate, const String* keys, const String* values, Int32 count, ZEROCONFERROR error, void * context)  ;

alias PluginHelpDelegate = Bool function(ref const String  optype, ref const String  main, ref const String  group, ref const String  property);


alias void ThreadMain(void *data);
alias Bool ThreadTest(void *data);
alias const Char *ThreadName(void *data);
alias void ProgressHook(Float p, RENDERPROGRESSTYPE progress_type, void * context);
alias void WriteProgressHook(WRITEMODE mode, BaseBitmap* bmp, ref const Filename  fn, Bool mainImage, Int32 frame, Int32 renderTime, Int32 streamnum, ref const String  streamname, void * context);
alias void BakeProgressHook(BakeProgressInfo* info);

alias void *HierarchyAlloc(void *main);
alias void HierarchyFree(void *main, void *data);
alias void HierarchyCopyTo(void *main, void *src, void *dst);
alias Bool HierarchyDo(void *main, void *data, BaseObject *op, ref const Matrix  mg, Bool controlobject);

alias void PopupEditTextCallback(Int32 mode, ref const String  text, void *userdata);

//alias void(*LASTCURSORINFOFUNC)();
alias LASTCURSORINFOFUNC = void function();

//alias Bool (*SaveCallbackImageFunc)(RDATA_SAVECALLBACK_CMD cmd, void * userdata, BaseDocument* doc, Int32 framenum, BaseBitmap* bmp, ref const Filename  fn);
alias SaveCallbackImageFunc = Bool function(RDATA_SAVECALLBACK_CMD cmd, void* userdata, BaseDocument* doc, Int32 framenum, BaseBitmap* bmp, ref const Filename  fn);

alias Bool BackgroundHandler(void *data, BACKGROUNDHANDLERCOMMAND command, BACKGROUNDHANDLERFLAGS parm);

//alias void(*C4D_CrashHandler)(Char *crashinfo);
//alias void(*C4D_CreateOpenGLContext)(void * context, void * root, UInt32 flags);
//alias void(*C4D_DeleteOpenGLContext)(void * context, UInt32 flags);
alias C4D_CrashHandler = void function(Char *crashinfo);
alias C4D_CreateOpenGLContext = void function(void* context, void* root, UInt32 flags);
alias C4D_DeleteOpenGLContext = void function(void* context, UInt32 flags);


//alias GeData CodeEditorCallback(BaseList2D *obj, ref const BaseContainer  msg);
//alias void(*V_CODE)(Coffee*, ref VALUE* , Int32);
alias V_CODE =  void function(Coffee*, ref VALUE* , Int32);

alias void*			UVWHandle;
alias const(void)*  ConstUVWHandle;
alias void*			NormalHandle;
alias const(void)*  ConstNormalHandle;


/+
alias /*extern(C)*/ ref int function(ref int lhs, ref int rhs) Ftype;
Ftype fprt;
+/

/// structure definitions
struct UVWStruct
{
	this(_DONTCONSTRUCT dc) { a = (DC); b = (DC); c = (DC); d = (DC); }

	//UVWStruct(void) {}
	this(ref const Vector  t_a, ref const Vector  t_b, ref const Vector  t_c, ref const Vector  t_d) { a=t_a; b=t_b; c=t_c; d=t_d; }
	this(ref const Vector  t_a, ref const Vector  t_b, ref const Vector  t_c) { a=t_a; b=t_b; c=t_c; }

	Vector a,b,c,d;

	//? ref Vector  operator[](Int32 index) const { return (cast(Vector*)this)[index & 3]; }
};

struct NormalStruct
{
	Vector a,b,c,d;

	//NormalStruct() {}
	this(_DONTCONSTRUCT dc) { a = (DC); b = (DC); c = (DC); d = (DC);}
	this(ref const Vector  t_a, ref const Vector  t_b, ref const Vector  t_c, ref const Vector  t_d) { a=t_a; b=t_b; c=t_c; d=t_d; }

	//? ref Vector  operator[](Int32 index) const { return (cast(Vector*)this)[index & 3]; }
};

struct IconData
{
	BaseBitmap			*bmp = null;
	Int32				x=0,y=0,w=0,h=0;
	ICONDATAFLAGS		flags = ICONDATAFLAGS_0;

	//? static IconData opCall() { bmp = (null); x = (0); y = (0); w = (0); h = (0); flags = (ICONDATAFLAGS_0); }
	this(BaseBitmap *t_bmp, Int32 t_x, Int32 t_y, Int32 t_w, Int32 t_h) { bmp = (t_bmp); x = (t_x); y = (t_y); w = (t_w); h = (t_h); flags = (ICONDATAFLAGS_0); }

	// returns a copy of the part of the IconData.
	BaseBitmap* GetClonePart() const {
		if (!bmp)	return nullptr;
		BaseBitmap* res = bmp.GetClonePart(x, y, w, h);
		if (!res)	return nullptr;
		res.SetData(BASEBITMAP_DATA_GUIPIXELRATIO, bmp.GetData(BASEBITMAP_DATA_GUIPIXELRATIO, GeData(1.0)));
		return res;
	}
	// returns the scaled bitmap with the size GetGuiW()/GetGuiH()
	BaseBitmap* GetGuiScalePart() const {
		if (!bmp)	return nullptr;

		Int32		dw	= GetGuiW();
		Int32		dh	= GetGuiH();
		BaseBitmap* res = BaseBitmap.Alloc();
		if (!res || (IMAGERESULT_OK != res.Init(dw, dh)))	{
			BaseBitmap.Free(res);
			return nullptr;
		}

		if (bmp.GetInternalChannel() != nullptr)
			res.AddChannel(true, false);

		bmp.ScaleBicubic(res, x, y, x + w - 1, y + h - 1, 0, 0, dw - 1, dh - 1);
		res.SetData(BASEBITMAP_DATA_GUIPIXELRATIO, GeData(1.0) );
		return res;
	}
	Int32 GetGuiW() const {
		if (!bmp)	return w;
		Float f = bmp.GetData(BASEBITMAP_DATA_GUIPIXELRATIO, GeData(1.0)).GetFloat();
		Int32 d = w;
		if (f != 0.0)	{
			d = cast(Int32)(d / f);
		}
		return d;
	}

	Int32 GetGuiH() const {
		if (!bmp)	return h;
		Float f = bmp.GetData(BASEBITMAP_DATA_GUIPIXELRATIO, GeData(1.0)).GetFloat();
		Int32 d = h;
		if (f != 0.0)	{
			d = cast(Int32)(d / f);
		}
		return d;
	}
};

struct ModelingCommandData
{
	//static ModelingCommandData opCall() { doc=null; op=null; bc=null; mode=MODELINGCOMMANDMODE_ALL; flags=MODELINGCOMMANDFLAGS_0; result=null; arr=null; }
	~this(){
		//? AtomArray.Free(result);
	}

	BaseDocument*			doc=null;
	BaseObject*				op=null;
	BaseContainer*			bc=null;
	MODELINGCOMMANDMODE		mode=MODELINGCOMMANDMODE_ALL;
	MODELINGCOMMANDFLAGS	flags=MODELINGCOMMANDFLAGS_0;

	AtomArray*				arr=null;
	AtomArray*				result=null;
};

struct MultiPassChannel
{
	Int32   id;
	String *name;
	MULTIPASSCHANNEL flags;
};

alias nothrow Int32 function(Int32 cmd, void *userdata,ref const Filename logfile) GeExecuteProgramExCallback;
alias nothrow Int32 function(ref const Filename item, Int flags, void *userdata ) GeFileMonitorCallback;
//============================================================================
struct C4D_General //! todo 
{
nothrow:
@nogc: 

	void						function(void *data) Free;
	void						function(ref const String  str) Print;

	Bool						function(const Filename *name, Bool isdir) FExist;
	Bool						function(const Filename *directory, const Filename *name, Filename *found) SearchFile;
	Bool						function(const Filename *name, Int32 flags) FKill;
	Bool						function(const Filename *source, const Filename *dest, Int32 flags) FCopyFile;
	Bool						function(const Filename *source, const Filename *dest) FRename;
	Bool						function(const Filename *name) FCreateDir;
	Bool						function(const Filename *path) ExecuteFile;
	const Filename	            function() GetStartupPath; //ref ????
	Bool						function(const Filename *program, const Filename *file) ExecuteProgram;

	void						function(Int32 v) ShowMouse;
	void						function(Int32 *year, Int32 *month, Int32 *day, Int32 *hour, Int32 *minute, Int32 *second) GetSysTime;
	Int32						function() GetTimer;
	void						function(String *str) GetLineEnd;
	Int32						function() GetDefaultFPS;
	GEMB_R					    function(const String *str, GEMB flags) OutString;
	OPERATINGSYSTEM             function() GetCurrentOS;
	BYTEORDER			        function() GetByteOrder;
	void						function(Int32 *r, Int32 *g, Int32 *b) GetGray;
	Bool						function(Vector *col, Int32 flags) ChooseColor;
	void						function(Int32 l) SetMousePointer;
	Bool						function(const Filename *fn) ShowBitmap1;
	Bool						function(BaseBitmap *bm) ShowBitmap2;
	void						function() StopAllThreads;
	void						function() StatusClear;
	void						function() StatusSetSpin;
	void						function(Int32 p) StatusSetBar;
	void						function(const String *str) StatusSetText;
	void						function(Int32 type, UInt p1, UInt p2) SpecialEventAdd;
	Bool						function(DRAWFLAGS flags, BaseDraw *bd) DrawViews;
	void						function(Int32 i, Filename *fn) GetGlobalTexturePath;
	void						function(Int32 i, const Filename *fn) SetGlobalTexturePath;
	void						function() FlushUnusedTextures;
	void						function(BaseContainer *bc) GetWorldContainer;
	void						function(CHECKVALUERANGE type, Float x, Float y, CHECKVALUEFORMAT cfv) ErrorStringDialog;

	void						function(BaseDocument *doc) InsertBaseDocument;
	void						function(BaseDocument *doc) SetActiveDocument;
	BaseDocument*		        function() GetActiveDocument;
	BaseDocument*		        function() GetFirstDocument;
	void						function(BaseDocument *doc) KillDocument;
	Bool						function(const Filename *name) LoadFile;
	Bool						function(BaseDocument *doc, ref const Filename  name, SAVEDOCUMENTFLAGS saveflags, Int32 format) SaveDocument;
	RENDERRESULT 		        function(BaseDocument *doc, ProgressHook *pr, void *private_data, BaseBitmap *bmp, const BaseContainer *rdata, RENDERFLAGS renderflags, BaseThread *th) RenderDocumentEx;
	Vector					    function(Int32 i) GetColor;
	Bool						function(Int32 api_version, PLUGINTYPE type, Int32 id, const String *str,void *data,Int32 datasize) RegisterPlugin;
	void						function(SERIALINFO type, String *s1, String *s2, String *s3, String *s4, String *s5, String *s6) GetSerialInfo;
	VERSIONTYPE			        function() GetVersionType;
	Bool						function(Int32 pluginid, Int8 *buffer, Int32 size) ReadPluginInfo;
	Bool						function(Int32 pluginid, Int8 *buffer, Int32 size) WritePluginInfo;

	void						function(EditorWindow *win, Int32 x1,Int32 y1,Int32 x2,Int32 y2) EwDrawXORLine;
	void						function(EditorWindow *win, Int32 button,Float mx,Float my,MOUSEDRAGFLAGS flag) EwMouseDragStart;
	MOUSEDRAGRESULT             function(EditorWindow *win, Float *mx,Float *my,BaseContainer *channels) EwMouseDrag;
	MOUSEDRAGRESULT             function(EditorWindow *win) EwMouseDragEnd;
	Bool						function(EditorWindow *win, Int32 askdevice,Int32 askchannel,BaseContainer *res) EwBfGetInputState;
	Bool						function(EditorWindow *win, Int32 askdevice,BaseContainer *res) EwBfGetInputEvent;

	Bool						function(Int32 sub_id, REGISTRYTYPE main_id, void *data) RegistryAdd;
	Bool						function(Int32 sub_id, REGISTRYTYPE main_id) RegistryRemove;
	Registry*				    function(Int32 sub_id, REGISTRYTYPE main_id) RegistryFind;
	Registry*				    function(REGISTRYTYPE main_id) RegistryGetLast;
	Registry*				    function(REGISTRYTYPE main_id) RegistryGetFirst;
	Bool						function(Int32 *id) RegistryGetAutoID;
	Bool						function(Registry *reg, REGISTRYTYPE *main_id, Int32 *sub_id, void **data) RegistryGetData;

	void *						function(Int size,Int32 line,const(char) *file) Alloc;
	BaseContainer*	            function(Int32 id) GetWorldPluginData;
	Bool						function(Int32 id, const BaseContainer *bc, Bool add) SetWorldPluginData;
	Bool                        function(Int32 message, Int32 core_id, Int par1, Int par2) SyncMessage;
	void						function(const BaseContainer *bc) SetWorldContainer;
	Bool						function(Int32 id, void *data) PluginMessage;

	BasePlugin*			        function(Int32 id, PLUGINTYPE type) FindPlugin;
	BasePlugin*			        function() GetFirstPlugin;
	void *						function(BasePlugin *this_ptr) GetPluginStructure;
	Filename				    function(BasePlugin *this_ptr) GetFilename;  //ref ????
	Int32						function(const BasePlugin *this_ptr) GetID ; //const;
	Int32						function(const BasePlugin *this_ptr) GetInfo ; //const;

	Bool						function(BaseContainer *col) ChooseFont;

	void						function(Int32 line, const Int8 *file) GeDebugBreak;
	void						function(const Int8* s,...) GeDebugOut;
	Bool						function(String *str) RenameDialog;
	Bool						function(ref const String  webaddress) OpenHTML;
	Bool						function(Int32 command, ref ModelingCommandData  data) SendModelingCommand;

	void						function(EVENT flags) EventAdd;
	void						function(BaseList2D *bl) FindInManager;

	CUSTOMDATATYPEPLUGIN*		function(Int32 type) FindCustomDataTypePlugin;
	RESOURCEDATATYPEPLUGIN*	    function(Int32 type) FindResourceDataTypePlugin;

	void						function(Int32 milliseconds) GeSleep;
	GeData					    function(Int32 coreid, ref const BaseContainer  msg, Int32 eventid) SendCoreMessage; //ref ????
	Bool						function(CHECKISRUNNING type) CheckIsRunning;
	BaseContainer*	            function() GetWorldContainerInstance;

	Bool						function(ref const Filename  docpath, ref const Filename  srcname, ref const Filename  suggestedpath, Filename *dstname) GenerateTexturePathEx;
	Bool						function(ref const Filename  texfilename, ref const Filename  docpath) IsInSearchPath;

	BaseContainer*	            function(BaseDocument *doc, Int32 id) GetToolPluginData;
	Bool						function() IsMainThread;


	Filename				    function(Int32 id) GetDefaultFilename; //ref ????

	Bool						function(BackgroundHandler *handler, void *tdata, Int32 typeclass, Int32 priority) AddBackgroundHandler;
	Bool						function(void *tdata, Int32 typeclass) RemoveBackgroundHandler;
	void						function(Int32 typeclass, BACKGROUNDHANDLERFLAGS flags) StopBackgroundThreads;
	Bool						function(Int32 typeclass, Bool all) CheckBackgroundThreadsRunning;
	void						function(Int32 typeclass) ProcessBackgroundThreads;

	void						function(const Filename *docpath, const String *name, ref const Filename  suggestedfolder) FlushTexture;

	Bool						function(const Filename *name, Int32 *frames, Float *fps) GetMovieInfo;
	String                      function(Int32 type) GetObjectName;
	String                      function(Int32 type) GetTagName;
	Int32                        function(ref const String  name) GetObjectType;
	Int32                        function(ref const String  name) GetTagType;

	void                        function(ref const String  str) CopyToClipboard;

	void *						function(Int size,Int32 line,const(char) *file) AllocNC;
	BaseContainer*	            function(BaseDocument *doc,Int32 pluginid) GetToolData;
	Bool						function(ref BaseContainer  stat) GeGetMemoryStat;
	Bool						function(Int32 screenx,Int32 screeny, Int32 width, Int32 height,ref const String  changeme,Int32 flags,PopupEditTextCallback *func, void *userdata) PopupEditText;

	Bool						function(EditorWindow *win, Int32 *x, Int32 *y) EWScreen2Local;
	Bool						function(EditorWindow *win, Int32 *x, Int32 *y) EWLocal2Screen;

	void						function(Bool active_only, Bool raybrush, Int32 x1, Int32 y1, Int32 x2, Int32 y2, BaseThread *bt, BaseDraw *bd, Bool newthread) StartEditorRender;

	GeData 					    function(ref const String  text, Int32 format, Int32 fps, const LENGTHUNIT *unit) StringToNumber; //ref ????

	Bool						function() IsActiveToolEnabled;
	SYSTEMINFO			        function() GetSystemInfo;
	Bool						function(void *par1) PrivateSystemFunction01;
	Bool						function(Int32 index, String *extension, String *name, Bool *default_language) GetLanguage;

	GeListHead*			        function(Int32 type) GetScriptHead;
	Int32						function(BaseList2D *bl) GetDynamicScriptID;
	Float						function(BaseDraw* bd, AtomArray* arr, Bool all, Int32 mode) GetToolScale;
	Bool						function(ref C4DPL_CommandLineArgs  args) GetCommandLineArgs;
	Bool						function(ref AtomArray  arr, PLUGINTYPE type, Bool sortbyname) FilterPluginList;

	Bool						function(BaseDocument *doc, ref const Filename  name, SCENEFILTER loadflags, BaseThread *bt) LoadDocumentExEx;
	void						function(BaseDocument *doc) FrameScene;
	IDENTIFYFILE		        function(ref const Filename  name, UChar *probe, Int32 probesize, IDENTIFYFILE recognition, BasePlugin **bp) IdentifyFile;
	const Filename	            function(Int32 whichpath) GetC4DPath; //ref ????

	Bool						function(ref const Filename  source, ref const Filename  dest) FMove;

	Bool						function(Int32 command_id, BaseDocument *doc, BaseDraw *bd, Int32 *value) HandleViewCommand;

	Bool						function(BaseDocument *doc, void *dat, UNDOTYPE type) AddUndoHandler;

	String					    function() GeGetDegreeChar;
	String					    function() GeGetPercentChar;
	Bool						function(Int32 command_id, Int32 *value) HandleCommand;

	void						function(void *adr, Int cnt) lSwap;
	void						function(void *adr, Int cnt) wSwap;
	void						function(void *adr, Int cnt) lIntel;
	void						function(void *adr, Int cnt) wIntel;
	void						function(void *adr, Int cnt) lMotor;
	void						function(void *adr, Int cnt) wMotor;
	void						function(void *adr, Int cnt) llSwap;
	void						function(void *adr, Int cnt) llIntel;
	void						function(void *adr, Int cnt) llMotor;

	void *						function(const UChar *key, Int32 klength, Bool stream) GeCipher256Open;
	void						function(void * h) GeCipher256Close;

	IpConnection*		        function(IpConnection* listener, BaseThread* connection, Int32 *ferr) IpWaitForIncoming;
	void						function(IpConnection* ipc) IpCloseConnection;
	void						function(IpConnection *ipc) IpKillConnection;
	Int							function(IpConnection* ipc) IpBytesInInputBuffer;
	Int							function(IpConnection* ipc, void * buf, Int size) IpReadBytes;
	Int							function(IpConnection* ipc, void * buf, Int size) IpSendBytes;
	void						function(IpConnection* ipc, Int8 *buf, Int32 bufsize) IpGetHostAddr;
	void						function(IpConnection* ipc, Int8 *buf, Int32 bufsize) IpGetRemoteAddr;

	Bool						function(Int32 command_id, Int32 flags, ref const String  str) RecordCommandEx;

	Bool						function() SendMailAvailable;
	Bool						function(ref const String  t_subject, const String *t_to, const String *t_cc, const String *t_bcc, Filename *t_attachments,ref const String  t_body, Int32 flags) SendMail;
	Bool						function(ref const String  varname, ref String  result) GetSystemEnvironmentVariable;
	Bool						function(ref const String  optype, ref const String  main, ref const String  group, ref const String  property) CallHelpBrowser;
	String					    function(ref const GeData  val, Int32 format, Int32 fps, Bool bUnit, LENGTHUNIT *unit) FormatNumber;

	void			            function(BaseContainer *plugincontainer,Int32 *id) BuildGlobalTagPluginContainer;
	Int32			            function(Int32 *id) ResolveGlobalTagPluginContainer;
	Vector					    function(Int32 cid) GetGuiWorldColor;

	Int32						function() GetShortcutCount;
	BaseContainer		        function(Int32 index) GetShortcut;
	Bool						function(ref const BaseContainer  bc) AddShortcut;
	Bool						function(Int32 index) RemoveShortcut;
	Bool						function(ref const Filename  fn, Bool add) LoadShortcutSet;
	Bool						function(ref const Filename  fn) SaveShortcutSet;
	Int32						function(Int32 pluginid, Int32 *indexarray, Int32 maxarrayelements) FindShortcutsFromID;
	Int32						function(ref const BaseContainer  scut, Int32 *pluginidarray, Int32 maxarrayelements) FindShortcuts;
	void						function(Int32 colid, ref const Vector  col) SetViewColor;

	void						function(BasePlugin *plug) RemovePlugin;

	Bool						function( void *p, Int *out_size) GetAllocSize;
	void                        function(BaseDocument *doc, BaseObject *op, BaseObject *activeobj) InsertCreateObject;

	void						function(void *h, UChar *mem, Int32 size) GeCipher256Encrypt;
	void						function(void *h, UChar *mem, Int32 size) GeCipher256Decrypt;

	IpConnection*		        function(UInt32 ipAddr, Int32 port, BaseThread* thread, Int32 timeout, Bool dontwait, Int32* ferr) IpOpenListener;
	IpConnection*		        function(Int8* hostname, BaseThread* thread, Int32 initial_timeout, Int32 timeout, Bool dontwait, Int32* ferr) IpOpenOutgoing;
	String					    function(ref const LocalFileTime  t, Bool date_only) DateToString;
	Bool						function(ref const Filename  fn, Bool open) ShowInFinder;

	Bool						function(ref const Filename  fn) WriteLayout;
	Bool						function(ref const Filename  fn) WritePreferences;
	Bool						function(BaseDocument *t_doc, ref const Filename  directory, Bool allow_gui) SaveProjectCopy;

	Int32						function(CDialog *parent,Int32 screenx,Int32 screeny,const BaseContainer *bc,Int32 flags, Int32 *res_mainid) ShowPopupMenu;

	Bool						function(ref const String  msg, ref const String  caption, Bool bAllowSuperUser, void **token) AskForAdministratorPrivileges;
	void						function() EndAdministratorPrivileges;
	void						function(const UInt16* param, Int32 exitcode, const UInt16** path) RestartApplication;
	const Filename	            function() GetStartupApplication; //ref ????

	Bool						function(EditorWindow *win, Int32 *x, Int32 *y) EWGlobal2Local;
	Bool						function(EditorWindow *win, Int32 *x, Int32 *y) EWLocal2Global;

	Bool						function(ref const Filename  fn, ref Filename  res) RequestFileFromServer;
	Bool						function(Int32 pluginid, Int8 *buffer, Int32 size) ReadPluginReg;
	Bool						function(Int32 pluginid, Int8 *buffer, Int32 size) WritePluginReg;
	Bool						function(ref const Filename  vol, ref UInt64  freecaller, ref UInt64  total, ref UInt64  freespace) GeFGetDiskFreeSpace;
	UInt32						function(const Filename *name) GeFGetAttributes;
	Bool						function(const Filename *name, UInt32 flags, UInt32 mask) GeFSetAttributes;

	void						function(Int32 mx, Int32 my, Int32 defw, Int32 defh, Int32 pluginwindowid, Int32 presettypeid, void *userdata, BrowserPopupCallback callback) BrowserLibraryPopup;
	Bool						function(ref const Filename  program, const String *args, Int32 argcnt, GeExecuteProgramExCallback callback, void *userdata) GeExecuteProgramEx;
	Float64						function() GeGetMilliSeconds;

	void *						function(void *old_data, Int new_size, Int32 line, const(char) *file) ReallocNC;
	Bool						function(ref BaseContainer  stat, void *in_allocator) GeGetAllocatorStatistics;
	UInt					    function() GeMemGetFreePhysicalMemoryEstimate;
	void                        function(BaseBitmap *map, Int32 ownerid) CopyToClipboardB;
	Bool                        function(String *txt) GetStringFromClipboard;
	Bool                        function(BaseBitmap *map) GetBitmapFromClipboard;
	CLIPBOARDTYPE               function() GetClipboardType;

	void						function(Bool external_only) EndGlobalRenderThread;
	Int32						function(Int32 on) GeDebugSetFloatingPointChecks;
	Int32						function() GetC4DClipboardOwner;
	void						function(void *memptr) GeCheckMem;

	Bool						function(ref const Filename  name, Int32 mode, LocalFileTime *lft_out) GetFileTime;
	Bool						function(ref const Filename  name, Int32 mode, const LocalFileTime *lft_in) SetFileTime;
	void						function(LocalFileTime *lft_out) GetCurrentTime;

	void						function() GeUpdateUI;
	Float						function(const UnitScaleData *src_unit, const UnitScaleData *dst_unit) CalculateTranslationScale;
	Int32						function(ref const String  txt) CheckPythonColor;

	void						function(ref const String  str) PrintNoCR;
	const BaseBitmap*           function(Int32 type, ref Int32  hotspotx, ref Int32  hotspoty) GetCursorBitmap;
	Filename*				    function() GetLocalFilename;

	Bool						function(BaseDocument *doc, ref const Filename  name, SCENEFILTER loadflags, BaseThread *bt, BaseDocument *srcdoc) LoadDocumentEx;
	Bool						function(Int32 id,Int32 key,Int32 qual) CheckCommandShortcut;
	BasePlugin*			        function(ref const String  foldername, BasePlugin *bs) CreatePluginEntry;
	void						function(BasePlugin *parent, BasePlugin *pred) SetLocalHierarchy;

	Bool						function(Int32 command_id, Int32 flags, ref const String  str, SCRIPTMODE mode) RecordCommand;
	Bool						function(Int32 command_id, Int32 flags, ref const String  str, SCRIPTMODE mode) PyRecordCommand;

	void						function(const Int8 *buf) PrintClean;

	Bool						function( ref const Filename  folder, GeFileMonitorCallback callback, void *userdata) WatchFolder;
	Bool						function( ref const Filename  folder, GeFileMonitorCallback callback, void *userdata) DontWatchFolder;
	Bool						function( ref const Filename  file, GeFileMonitorCallback callback, void *userdata) WatchFile;
	Bool						function( ref const Filename  file, GeFileMonitorCallback callback, void *userdata) DontWatchFile;
	Bool						function(Bool shutdown) ShutdownThreads;

	void *						function(Int32 threadidx, Int size, Bool clear) AllocTH;
	void						function(Int32 threadidx, ref void * ptr) FreeTH;

	Bool						function( Int32 x, Int32 y, Bool whole_screen, Int32 *sx1, Int32 *sy1, Int32 *sx2, Int32 *sy2) GetScreenDimensions;

	Int32						function(Int32 num) GetCOFFEEDictionaryID;
	String*					    function(Int32 num) GetCOFFEEDictionaryName;
	Int32						function() GetCOFFEEDictionaryCount;
	Bool						function() GetCOFFEEDictionaryState;

	Bool						function(EditorWindow *win, Int32 id) EwBfIsHotkeyDown;


	void						function(Bool value) ForceStopApplication;

static if(API_VERSION >= 15000) { //R15 only

	//Bool						(*SaveProject )(BaseDocument *doc, SAVEPROJECT flags, Filename targetPath, maxon.BaseArray!(AssetEntry)* assets, maxon.BaseArray!(AssetEntry)* missingAssets);
	Bool						function(BaseDocument *doc, SAVEPROJECT flags, Filename targetPath, maxon.BaseArray!(AssetEntry)* assets, maxon.BaseArray!(AssetEntry)* missingAssets) SaveProject; //TODO
	//Bool						(*GetAllAssets )(BaseDocument *doc, Bool allowDialogs,ref maxon.BaseArray!(AssetEntry) assets,ref Filename lastPath);
	Bool						function(BaseDocument *doc, Bool allowDialogs,ref maxon.BaseArray!(AssetEntry) assets,ref Filename lastPath) GetAllAssets; //TODO

	RENDERRESULT 				function(BaseDocument *doc, WriteProgressHook *wprog, ProgressHook *prog, void *private_data, BaseBitmap *bmp, const BaseContainer *rdata, RENDERFLAGS renderflags, BaseThread *th, void *data)RenderDocument;

	UInt32						function(CINEMAINFO info)GetCinemaInfo;
	void						function()SaveWorldPreferences;

	//Bool						(*Assemble )(const Filename &inputpath, const String &inputname, BaseContainer& rdata, WriteProgressHook* wprog, void* context, Bool assembleRegular, Bool assembleMultipass, BaseThread *bt, Int32 ifrom, Int32 ito, String *errorstring, Int32 streamstart, Int32 streamcnt, const maxon.BaseArray!String>& stereoimages, Bool clearimages);
	Bool						function(ref const Filename  inputpath, ref const String  inputname, ref BaseContainer  rdata, WriteProgressHook* wprog, void * context, Bool assembleRegular, Bool assembleMultipass, BaseThread *bt, Int32 ifrom, Int32 ito, String *errorstring, Int32 streamstart, Int32 streamcnt, ref const maxon.BaseArray!(String) stereoimages, Bool clearimages)Assemble;

	String						function(ref const String  macmodel)GetMacModel;

	Filename					function(ref const Filename  name, Int32 id)FilterSetSuffix;

	void						function()StatusNetClear;
	void						function(STATUSNETSTATE status)StatusSetNetLoad;
	void						function(Int32 p, ref const GeData  dat)StatusSetNetBar;
	void						function(const String *str)StatusSetNetText;

	Bool						function(BaseDocument *doc, ref const Filename  name, SCENEFILTER loadflags, BaseThread *bt, BaseDocument *srcdoc, String* errString) LoadDocument;
	Bool						function(ref const Filename  docpfad, ref const Filename  texturname, ref const Filename  suggestedfolder, Filename *filename, NetRenderService* client, BaseThread* bt)GenerateTexturePath;

	void						function(BaseDocument* doc, Bool useNet)RenderExternal;
	Bool						function(BaseBitmap* t_bmp, void * userdata)PVFinalizeImage;
	Filename					function(ref const Filename  bildname, Int32 bildformat, Int32 nameformat, Int32 bildnum, ref const String  streamname, String *middle, Bool clearsuffix, Bool stream_folders)GenEndung;

	void						function(Int32 exitCode)	SetExitCode;

	//Bool						(*GetAllAssetsNet)(BaseDocument *doc, Bool allowDialogs, maxon.BaseArray!AssetEntry>& assets, Filename& lastPath, Bool isNet);
	Bool						function(BaseDocument *doc, Bool allowDialogs, ref maxon.BaseArray!(AssetEntry) assets, ref Filename  lastPath, Bool isNet) GetAllAssetsNet;
	
	//RENDERRESULT 				(*RenderDocumentNet	)(BaseDocument *doc, WriteProgressHook *wprog, ProgressHook *prog, void *private_data, BaseBitmap *bmp, const BaseContainer *rdata, RENDERFLAGS renderflags, BaseThread *th, void *data, const maxon.BaseArray!Bool>* renderTask);
	RENDERRESULT 				function(BaseDocument *doc, WriteProgressHook *wprog, ProgressHook *prog, void *private_data, BaseBitmap *bmp, const BaseContainer *rdata, RENDERFLAGS renderflags, BaseThread *th, void *data , const maxon.BaseArray!(Bool)* renderTask) RenderDocumentNet;
	
	void						function(ref const String  optype, ref const String  main, ref const String  group, ref const String  property)OpenHelpBrowser;
	//Bool						function(Int32, Bool (*)(ref const String  optype, ref const String  main, ref const String  group, ref const String  property)) RegisterPluginHelpDelegate;
	Bool						function(Int32, PluginHelpDelegate) RegisterPluginHelpDelegate;
	Bool						function(ref const String  optype, ref const String  main, ref const String  group, ref const String  property)IteratePluginHelpDelegates;
} //R15

};

//pragma(msg,C4D_General.sizeof/8);

//============================================================================
struct C4D_Shader
{
nothrow:
@nogc: 

	Float			        function(Vector p)SNoise;
	Float					function(Vector p, Float t)SNoiseT;
	Float					function(Vector p)Noise;
	Float					function(Vector p, Float t)NoiseT;
	Float					function(Vector p, Vector d)PNoise;
	Float					function(Vector p, Float t, Vector d, Float dt)PNoiseT;
	Float					function(Vector p, Float oct, Bool abs)Turbulence;
	Float					function(Vector p, Float t, Float oct, Bool abs)TurbulenceT;
	Float					function(Vector p, Float t, Float oct, Float start)WavyTurbulence;
	void					function(Float *table, Int32 max_octaves, Float lacunarity, Float h)InitFbm;
	Float					function(Float *table, Vector p, Float oct)Fbm;
	Float					function(Float *table, Vector p, Float t, Float oct)FbmT;
	Float					function(Float *table, Vector p, Float oct, Float offset, Float gain)RidgedMultifractal;
	Float					function(Float x, Float *knot, Int32 nknots)CalcSpline;
	Vector					function(Float x, Vector *knot, Int32 nknots)CalcSplineV;

	void					function(VolumeData *sd, Vector *diffuse, Vector *specular, Float exponent)Illuminance1;

	Int32					function(VolumeData *sd)GetCurrentCPU;
	Int32					function(VolumeData *sd)GetCPUCount;
	void *					function(VolumeData *sd, Int32 i)GetRayData;

	RayObject*			    function(VolumeData *sd, Int32 i)GetObj;
	Int32					function(VolumeData *sd)GetObjCount;

	RayLight*				function(VolumeData *sd, Int32 i)GetLight;
	Int32					function(VolumeData *sd)GetLightCount;

	RayObject*			    function(VolumeData *sd, ref const RayHitID  id)ID_to_Obj;

	void					function(VolumeData *sd, RayObject *op, Int32 uvwind, Int32 i, PolyVector *uvw)GetUVW;
	Vector					function(VolumeData *sd, TexData *tdp, ref const RayHitID  lhit, ref const Vector64  p)GetPointUVW;
	void					function(VolumeData *sd, RayObject *op, Int32 polygon, PolyVector *norm)GetNormals;
	TexData*				function(VolumeData *sd, RayObject *op, Int32 index)GetTexData;
	Vector64				function(VolumeData *sd, RayObject *op, Int32 polygon, Bool second)GetNormal;
	Vector64				function(VolumeData *sd, ref const RayHitID  hit, ref const Vector64  p)GetSmoothedNormal;
	Bool					function(VolumeData *sd, ref const RayHitID  hit, ref const Vector64  p, Float *r, Float *s)GetRS;

	void					function(VolumeData *sd, Float x, Float y, Ray *ray)GetRay;
	Vector64				function(VolumeData *sd, ref const Vector64  p)ScreenToCamera;
	Vector64				function(VolumeData *sd, ref const Vector64  p)CameraToScreen;
	Bool					function(VolumeData *sd, TexData *tdp, ref const RayHitID  lhit, ref const Vector64  p, ref const Vector64  n, Vector *uv)ProjectPoint;

	VolumeData*			    function()AllocVolumeData;
	void					function(VolumeData *sd)FreeVolumeData;

	void					function(VolumeData *sd, const String *str)StatusSetText;
	void					function(VolumeData *sd, Float percentage)StatusSetBar;

	TexData*				function()AllocTexData;
	void					function(TexData *td)FreeTexData;
	void					function(TexData *td)InitTexData;

	Vector					function(VolumeData *sd, Ray *ray, Float maxdist, Vector *trans)CalcVisibleLight;
	void					function(VolumeData *sd, Int32 *x, Int32 *y, Int32 *scale)GetXY;

	Int32					function(VolumeData *sd, RayObject *obj)Obj_to_Num;
	Int32					function(VolumeData *sd, RayLight *light)Light_to_Num;

	void					function(VolumeData *src, VolumeData *dst)CopyVolumeData;

	Bool					function(Render *render, Int32 id, Int32 subid, Int32 bitdepth, Bool visible)VPAllocateBuffer;
	VPBuffer*				function(Render *render, Int32 id, Int32 subid)VPGetBuffer;
	Int32					function(VPBuffer *buf, VPGETINFO type)VPGetInfo;
	Bool					function(VPBuffer *buf, Int32 x, Int32 y, Int32 cnt, void *data, Int32 bitdepth, Bool dithering)VPGetLine;
	Bool					function(VPBuffer *buf, Int32 x, Int32 y, Int32 cnt, void *data, Int32 bitdepth, Bool dithering)VPSetLine;

	void					function(VolumeData *sd)OutOfMemory;
	Float					function(Int32 falloff, Float inner, Float outer, Float dist)GetLightFalloff;

	Bool					function(VolumeData *sd)TestBreak;

	void					function(Render *render, BaseContainer *bc)VPGetRenderData;
	void					function(Render *render, const BaseContainer *bc)VPSetRenderData;

	void					function(VolumeData *sd, Vector *diffuse, Vector *specular, IlluminationModel *model, void *data)Illuminance;

	BaseVideoPost*          function(VolumeData *sd, Int32 i, Bool index)FindVideoPost;
	VPFragment**		    function(VolumeData *sd, Int32 x, Int32 y, Int32 cnt, VPGETFRAGMENTS flags)VPGetFragments;
	Bool					function(VolumeData *sd, LensGlowStruct *lgs, Vector *lgs_pos, Int32 lgs_cnt, Float intensity)AddLensGlowEx;

	RayLight*				function(BaseDocument *doc, BaseObject *op)AllocRayLight;
	void					function(RayLight *lgt)FreeRayLight;

	Int32					function(VolumeData *sd, Int32 index, Bool old_to_new)TranslateObjIndex;
	Bool					function(VolumeData *sd, RayObject *op, Int32 local_index, Vector *previous_points)TranslatePolygon;
	Bool					function(VolumeData *sd, VPBuffer *rgba, VPBuffer *fx, BaseThread *bt)SampleLensFX;
	Int32					function(Render *render, Int32 id, ref const String  name, Int32 bitdepth, Bool visible)VPAllocateBufferFX;

	VolumeData*			    function(Render *render, Int32 cpu)VPGetInitialVolumeData;

	Bool					function(VolumeData *sd, Bool foreground, Int32 x, Int32 y, Int32 subx, Int32 suby, Vector *color, Float *alpha)CalcFgBg;
	Int32					function(VolumeData *sd, RayObject *op, Int32 i)GetRayPolyState;

	void					function(VolumeData *sd, ref const RayHitID  hit, ref const Vector64  p, RayPolyWeight *wgt)GetWeights;
	void					function(VolumeData *src, VolumeData *dst)InitVolumeData;

	Vector					function(VolumeData *sd, Ray *ray, Float maxdist, ref const RayHitID  lhit, SurfaceIntersection *si)TraceColor;
	Bool  					function(VolumeData *sd, Ray *ray, Float maxdist, ref const RayHitID  lhit, SurfaceIntersection *si)TraceGeometry;
	void  					function(VolumeData *sd, SurfaceDataEx *cd, Int32 calc_illum, Bool calc_shadow, Bool calc_refl, Bool calc_trans, Ray *ray, ref const SurfaceIntersection  si)GetSurfaceDataEx;

	void					function(VolumeData *sd)SkipRenderProcess;

	void *					function(Render *render)VPGetPrivateData;
	Render*					function(VolumeData *sd)GetRenderInstance;

	Vector					function(VolumeData *sd, RayObject *op, Int32 local_id, Int32 uu, Int32 vv)CentralDisplacePointUV;
	Vector					function(VolumeData *sd, Float par_u, Float par_v, Int32 u0, Int32 v0, Int32 u1, Int32 v1, Int32 u2, Int32 v2, ref const Vector  a, ref const Vector  b, ref const Vector  c, RayObject *op, Int32 polynum)CalcDisplacementNormals;

	Stratified2DRandom*     function()SNAlloc;
	void					function(Stratified2DRandom *rnd)SNFree;
	Bool					function(Stratified2DRandom *self, Int32 initial_value, Bool reset) SNInit;
	void					function(Stratified2DRandom *self, Float *xx, Float *yy) SNGetNext;    
	BAKE_TEX_ERR            function(BaseDocument* doc, ref const BaseContainer  data, BaseBitmap *bmp, BaseThread* th, BakeProgressHook* hook, BakeProgressInfo* info)BakeTexture;
	BaseDocument*           function(BaseDocument* doc, TextureTag* textag, UVWTag* texuvw, UVWTag* destuvw, ref const BaseContainer  bc, BAKE_TEX_ERR* err, BaseThread* th)InitBakeTexture;
	BaseDocument*           function(BaseDocument* doc, TextureTag** textags, UVWTag** texuvws, UVWTag** destuvws, Int32 cnt, ref const BaseContainer  bc, BAKE_TEX_ERR* err, BaseThread* th)InitBakeTextureA;

	void					function(VolumeData *vd, TexData *tex, ref const Vector64  p, ref const Vector64  phongn, ref const Vector64  orign, ref const RayHitID  hitid, Bool forceuvw, Vector *ddu, Vector *ddv)GetDUDVEx;
	void					function(VolumeData *sd, RayLight *light, Bool nodiffuse, Bool nospecular, Float specular_exponent, ref const Vector64  ray_vector, ref const Vector64  p, ref const Vector64  bumpn, ref const Vector64  orign, RAYBIT raybits, Vector *diffuse, Vector *specular)CalcArea;
	Bool					function(VolumeData *sd, RayLight *light, Vector *col, Vector64 *lv, ref const Vector64  p, ref const Vector64  bumpn, ref const Vector64  phongn, ref const Vector64  orign, ref const Vector64  ray_vector, ILLUMINATEFLAGS calc_shadow, ref const RayHitID  hitid, RAYBIT raybits, Bool cosine_cutoff, Vector *xshadow)Illuminate;
	void					function(VolumeData *sd, IlluminanceSurfacePointData *f, Vector *diffuse, Vector *specular)IlluminanceSurfacePoint;
	Vector					function(VolumeData *sd, ref const Vector64  p, ILLUMINATEFLAGS flags, RAYBIT raybits)IlluminanceAnyPoint;
	Vector					function(VolumeData *sd, RayLight *light, ref const Vector64  p, ref const Vector64  bumpn, ref const Vector64  phongn, ref const Vector64  orign, ref const Vector64  rayv, Bool transparency, ref const RayHitID  hitid, RAYBIT raybits)CalcShadow;

	Bool					function(Render *render, Int32 id, ref const GeData  dat)SetRenderProperty;
	void					function(VolumeData *sd, Float x, Float y)SetXY;
	void					function(VolumeData *sd, TexData *td)InitSurfacePointProperties;

	Float					function(Vector p, Float t, Int32 t_repeat)SNoiseP;
	Float					function(Vector p, Float t, Float oct, Bool abs, Int32 t_repeat)TurbulenceP;
	Float					function(Float *table, Vector p, Float t, Float oct, Int32 t_repeat)FbmP;
	Float					function(Float *table, Vector p, Float t, Float oct, Float offset, Float gain, Int32 t_repeat)RidgedMultifractalP;

	Bool					function(VolumeData *sd, BaseObject *camera, ref const BaseContainer  renderdata, void *priv)AttachVolumeDataFake;
	RayObject*			    function(Int32 tex_cnt, void *priv)AllocRayObject;
	void					function(RayObject *op)FreeRayObject;

	Bool  					function(VolumeData *sd, Ray *ray, Float maxdist, ref const RayHitID  lhit, Int32 raydepth, RAYBIT raybits, Vector64 *oldray, SurfaceIntersection *si)TraceGeometryEnhanced;
	Vector					function(VolumeData *sd, Ray *ray, Float maxdist, Int32 raydepth, RAYBIT raybits, ref const RayHitID  lhit, Vector64 *oldray, SurfaceIntersection *si)TraceColorDirect;

	Vector					function(VolumeData *sd, ref const Vector64  p1, ref const Vector64  p2, CALCHARDSHADOW flags, ref const RayHitID  lhit, Int32 recursion_id, void *recursion_data)CalcHardShadow;
	void					function(VolumeData *sd, Bool on)StatusSetSpinMode;

	Vector					function(ref const Vector  v, COLORSPACETRANSFORMATION colortransformation)TransformColor;

	void                    function(Render *rnd, void *data, Int32 xcnt, Int32 components, Bool inverse)VPIccConvert;

	Bool					function(VolumeData *sd, ref RayShaderStackElement * stack, ref Int32  stack_cnt)SaveShaderStack;
	Bool					function(VolumeData *sd, RayShaderStackElement *stack, Int32 stack_cnt)RestoreShaderStack;

	RayObject*			    function(VolumeData *sd, Int32 i)GetSky;
	Int32					function(VolumeData *sd)GetSkyCount;

	Bool					function(VolumeData *sd, LensGlowStruct *lgs, Vector *lgs_pos, Int32 lgs_cnt, Float intensity, Bool linear_workflow)AddLensGlow;
	RaySampler*			    function(VolumeData *sd, void *guid, Int32 depth)GetSampler;
	Float					function(VolumeData *sd)GetRayWeight;

	Float					function(VolumeData *sd, SurfaceIntersection *pSI, RaySampler *sampler, Float minlength, Float maxlength, Float index, Bool self, Bool trans, Float weight)CalcAmbientOcclusion;
	Vector					function(VolumeData *sd, Vector scattering, Vector absorption, Vector diffuse, Float ior)CalcSubsurfaceScattering;

	Int32					function(VolumeData *sd)GetStreamCount;
	void					function(VolumeData *sd, Int32 stream, Float x, Float y, Ray *ray)GetStreamRay;

	void					function(VolumeData *sd, ref Vector  min, ref Vector  max)GetSceneBoundaries;
	Bool					function(VolumeData *sd, const RayObject* op, ref DisplaceInfo  info)GetDisplaceInfo;
	Vector					function(VolumeData *sd, RayObject *op, Int32 local_id, Int32 uu, Int32 vv)CentralDisplaceUVGetNormal;
	Int32					function(VolumeData *sd, const RayObject* op, Int32 local_id, Int32 side)GetDisplaceNeighbor;

	Bool					function(VolumeData *sd, RayHemisphere *hs, Float weight)CalcIndirectIllumination;
	RayRadianceObject*	    function(VolumeData *sd)CreateRadianceMaps;
	RayRadianceObject*	    function(VolumeData *sd)GetRadianceMaps;
	Vector					function(VolumeData *sd, Ray *ray, ref const SurfaceIntersection  si)CalcRadianceValue;
	void					function(VolumeData *vd, TexData *tex, ref const Vector64  p, ref const Vector64  phongn, ref const Vector64  orign, ref const RayHitID  hitid, Bool forceuvw, Vector *ddu, Vector *ddv, Bool usetangents)GetDUDV;
	Bool					function(VolumeData *sd)IsPhysicalRender;
	Int32*					function(VolumeData *sd, RayObject *op, ref Int32  length)GetUniqueID;
	Bool					function(VolumeData *sd, ref const Vector  point, ref const Vector  normal, ref const Vector  ray_in, ref const Vector  ray_out, ref Float  pdf_qmc, ref Float  pdf_area, ref Float  pdf_portal, ref Float  pdf_sky)CalcIndirectPDF;
	Bool					function(VolumeData *sd, ref const Vector  dir, void *source, void *target)CalcIndirectPath;

	void  					function(VolumeData *sd, SurfaceData *cd, Int32 calc_illum, Bool calc_shadow, Bool calc_refl, Bool calc_trans, Ray *ray, ref const SurfaceIntersection  si)GetSurfaceData;

	Vector					function(VolumeData *sd, RayRadianceObject *obj, SurfaceIntersection *si, Int32 poly, Int32 u, Int32 v, Bool back)CalcRadiancePoly;
	void					function(VolumeData *sd, const RayObject* op, ref Int32  local_id)CorrectLocalID;
	Float					function(VolumeData *sd)GetPhysicalCameraIntensity;
	Bool					function(VolumeData *sd, RayObject *op, ref Int32  local_id, ref Int32  uu, ref Int32  vv, ref RayPolyWeight  bary, ref Bool  displaceQuad)CentralDisplacePointUVGetBarycentric;
	void					function(VolumeData *sd, Float time)SetPhysicalRayTime;
	Vector					function(VolumeData *sd)CalcBackTransformPoint;
};

//============================================================================
struct C4D_HyperFile
{
nothrow:
@nogc: 

	Bool				function(HyperFile *self, Int32 ident, ref const Filename name, FILEOPEN mode, FILEDIALOG error_dialog) Open;
	Bool				function(HyperFile *self,) Close;

	Bool				function(HyperFile *self, Char  v) WriteChar;
	Bool				function(HyperFile *self, UChar v) WriteUChar;
	Bool				function(HyperFile *self, Int16  v) WriteInt16;
	Bool				function(HyperFile *self, UInt16 v) WriteUInt16;
	Bool				function(HyperFile *self, Int32  v) WriteInt32;
	Bool				function(HyperFile *self, UInt32 v) WriteUInt32;
	Bool				function(HyperFile *self, Float  v) WriteFloat;
	Bool				function(HyperFile *self, Float32 v) WriteFloat32;
	Bool				function(HyperFile *self, Float64 v) WriteFloat64;
	Bool				function(HyperFile *self, Bool  v) WriteBool;
	Bool				function(HyperFile *self, ref const BaseTime v) WriteTime;
	Bool				function(HyperFile *self, ref const Vector v) WriteVector;
	Bool				function(HyperFile *self, ref const Vector32 v) WriteVector32;
	Bool				function(HyperFile *self, ref const Vector64 v) WriteVector64;
	Bool				function(HyperFile *self, ref const Matrix v) WriteMatrix;
	Bool				function(HyperFile *self, ref const Matrix32 v) WriteMatrix32;
	Bool				function(HyperFile *self, ref const Matrix64 v) WriteMatrix64;
	Bool				function(HyperFile *self, ref const String v) WriteString;
	Bool				function(HyperFile *self, ref const Filename v) WriteFilename;
	Bool				function(HyperFile *self, ref const BaseContainer v) WriteContainer;
	Bool				function(HyperFile *self, const void *data, Int count) WriteMemory;
	Bool				function(HyperFile *self, Int64 v) WriteInt64;

	Bool				function(HyperFile *self, Char         *v) ReadChar;
	Bool				function(HyperFile *self, UChar        *v) ReadUChar;
	Bool				function(HyperFile *self, Int16        *v) ReadInt16;
	Bool				function(HyperFile *self, UInt16        *v) ReadUInt16;
	Bool				function(HyperFile *self, Int32         *v) ReadInt32;
	Bool				function(HyperFile *self, UInt32        *v) ReadUInt32;
	Bool				function(HyperFile *self, Float         *v) ReadFloat;
	Bool				function(HyperFile *self, Float32        *v) ReadFloat32;
	Bool				function(HyperFile *self, Float64        *v) ReadFloat64;
	Bool				function(HyperFile *self, Bool         *v) ReadBool;
	Bool				function(HyperFile *self, BaseTime     *v) ReadTime;
	Bool				function(HyperFile *self, Vector       *v) ReadVector;
	Bool				function(HyperFile *self, Vector32      *v) ReadVector32;
	Bool				function(HyperFile *self, Vector64      *v) ReadVector64;
	Bool				function(HyperFile *self, Matrix       *v) ReadMatrix;
	Bool				function(HyperFile *self, Matrix32      *v) ReadMatrix32;
	Bool				function(HyperFile *self, Matrix64      *v) ReadMatrix64;
	Bool				function(HyperFile *self, String       *v) ReadString;
	Bool				function(HyperFile *self, Filename     *v) ReadFilename;
	Bool				function(HyperFile *self, BaseBitmap   *v) ReadImage;
	Bool				function(HyperFile *self, BaseContainer *v, Bool flush) ReadContainer;
	Bool				function(HyperFile *self, void **data, Int *size) ReadMemory;
	Bool				function(HyperFile *self, Int64 *v) ReadInt64;

	FILEERROR			function(const HyperFile *self,) GetError;// const;
	void				function(HyperFile *self, FILEERROR err) SetError;
	Bool				function(HyperFile *self, HYPERFILEVALUE *h) ReadValueHeader;
	Bool				function(HyperFile *self, HYPERFILEVALUE h) SkipValue;
	Bool				function(HyperFile *self, Int32 id, Int32 level) WriteChunkStart;
	Bool				function(HyperFile *self,) WriteChunkEnd;
	Bool				function(HyperFile *self, Int32 *id, Int32 *level) ReadChunkStart;
	Bool				function(HyperFile *self) ReadChunkEnd;
	Bool				function(HyperFile *self) SkipToEndChunk;
	BaseDocument*		function(HyperFile *self) GetDocument;// const;

	Int32				function(HyperFile *self,) GetFileVersion;// const;

	Bool				function(HyperFile *self, BaseBitmap *v, Int32 format, const BaseContainer *data, SAVEBIT savebits) WriteImage;
	Bool				function(HyperFile *self, const void *data, HYPERFILEARRAY type, Int32 structure_increment, Int32 count) WriteArray;
	Bool				function(HyperFile *self, void *data, HYPERFILEARRAY type, Int32 structure_increment, Int32 count) ReadArray;

	HyperFile*			function()AllocHF;
	void				function(ref HyperFile * hf)FreeHF;

	FILEERROR			function(BaseDocument *doc, GeListNode *node, ref const Filename  filename, Int32 ident, String *warning_string)ReadFile;
	FILEERROR			function(BaseDocument *doc, GeListNode *node, ref const Filename  filename, Int32 ident)WriteFile;

	Bool				function(HyperFile *hf, ref const GeData  v)WriteGeData;
	Bool				function(HyperFile *hf, ref GeData  v)ReadGeData;
	Bool				function(HyperFile *self, UInt64 *v) ReadUInt64;
	Bool				function(HyperFile *self, UInt64 v) WriteUInt64;

	void				function(HyperFile *self, Int32 val) SetFileVersion;
	Bool				function(HyperFile *self, C4DUuid *v) ReadUuid;
	Bool				function(HyperFile *self, ref const C4DUuid v) WriteUuid;
	LOCATION			function(const HyperFile *self) GetLocation;// const;
};

//? private ref const(GeData) GetData_Fn(const BaseContainer* this_ptr,Int32 id); //ref HACK;

//pragma(msg,"GetData_Fn: ",typeof(&GetData_Fn).stringof);
//============================================================================
//extern (C++)
struct C4D_BaseContainer
{
nothrow:
@nogc: 

	BaseContainer				*Default;

	BaseContainer*	            function(Int32 id) Alloc;
	void						function(BaseContainer *killme) Free;
	Bool						function(ref const BaseContainer  bc1, ref const BaseContainer  bc2) Compare;
	void *						function(const BaseContainer *bc, Int32 *id, GeData **data, void *handle) BrowseContainer;

	void						function(BaseContainer *this_ptr,Int32 id, const BaseContainer *src) SDKInit;
	BaseContainer*	            function(const BaseContainer *this_ptr,COPYFLAGS flags, AliasTrans *trans) GetClone ;  //const;
	void						function(BaseContainer *this_ptr) FlushAll;
	Int32						function(const  BaseContainer *this_ptr) GetId ;  //const;
	void						function(BaseContainer *this_ptr,Int32 newid) SetId;

	void						function(BaseContainer *this_ptr,Int32 id, void *v) SetVoid;
	void						function(BaseContainer *this_ptr,Int32 id, Float v) SetFloat;
	void						function(BaseContainer *this_ptr,Int32 id, Bool v) SetBool;
	void						function(BaseContainer *this_ptr,Int32 id, Int32 v) SetInt32;
	void						function(BaseContainer *this_ptr,Int32 id, ref const String  v) SetString;
	void						function(BaseContainer *this_ptr,Int32 id, ref const Filename  v) SetFilename;
	void						function(BaseContainer *this_ptr,Int32 id, ref const BaseTime  v) SetTime;
	void						function(BaseContainer *this_ptr,Int32 id, ref const BaseContainer  v) SetContainer;
	void						function(BaseContainer *this_ptr,Int32 id, ref const Vector  v) SetVector;
	void						function(BaseContainer *this_ptr,Int32 id, ref const Matrix  v) SetMatrix;

	//BaseContainer				function(const BaseContainer *this_ptr,Int32 id) GetContainer ; //const;
	void					    function(const BaseContainer *this_ptr,BaseContainer *result,Int32 id) GetContainer; //x64 ABI OK!

	BaseContainer*				function(const BaseContainer *this_ptr,Int32 id) GetContainerInstance;// const;

	Bool						function(BaseContainer *this_ptr,Int32 id) RemoveData;
	Int32						function(const BaseContainer *this_ptr,Int32 id, GeData **data) FindIndex ; //const;
	Int32						function(const BaseContainer *this_ptr,Int32 index) GetIndexId ; //const;
	Bool						function(BaseContainer *this_ptr,Int32 index) RemoveIndex;
	GeData*					    function(const BaseContainer *this_ptr,Int32 index) GetIndexData ; //const;

	BaseList2D*			        function(const BaseContainer *this_ptr,Int32 id, const BaseDocument *doc, Int32 instanceof) GetLink ; //const;
	void						function(BaseContainer *this_ptr,Int32 id, C4DAtomGoal *link) SetLink;

	alias ref const(GeData)		function(const BaseContainer* this_ptr,Int32 id) GetDataFT; GetDataFT GetData;  //ref workaround;
	//? ref const(GeData) 		function(const BaseContainer *this_ptr,Int32 id) GetData ; //const;

	Bool						function(const BaseContainer *this_ptr,ref const DescID  id, ref GeData  t_data) GetParameter ; //const;
	Bool						function(BaseContainer *this_ptr,ref const DescID  id, ref const GeData  t_data) SetParameter;

	GeData*					    function(BaseContainer *this_ptr,Int32 id, ref const GeData  n) InsData;
	GeData*					    function(BaseContainer *this_ptr,Int32 id, ref const GeData  n) SetData;
	void						function(BaseContainer *this_ptr,Int32 id, Int64 v) SetInt64;
	GeData*					    function(BaseContainer *this_ptr,Int32 id, ref const GeData  n, const GeData *last) InsDataAfter;
	Bool						function(const BaseContainer *this_ptr,BaseContainer *dest,COPYFLAGS flags,AliasTrans *trans) CopyTo ; //const;
	void						function(BaseContainer *this_ptr) Sort;

	Float						function(const BaseContainer *this_ptr,Int32 id, Float preset) GetFloat ; //const;
	Bool						function(const BaseContainer *this_ptr,Int32 id, Bool preset) GetBool ; //const;
	Int32						function(const BaseContainer *this_ptr,Int32 id, Int32 preset) GetInt32 ; //const;

	//String					function(const BaseContainer *this_ptr,Int32 id, ref const String  preset) GetString ; //const;
	void					    function(const BaseContainer *this_ptr,String *result,Int32 id, ref const String preset) GetString; //x64 ABI OK!

	//Filename				    function(const BaseContainer *this_ptr,Int32 id, ref const Filename  preset) GetFilename ; //const;
	void						function(const BaseContainer *this_ptr,Filename *result,Int32 id, ref const Filename preset) GetFilename; //x64 ABI OK!

	//BaseTime				    function(const BaseContainer *this_ptr,Int32 id, ref const BaseTime  preset) GetTime ; //const;
	void						function(const BaseContainer *this_ptr, BaseTime *result, Int32 id, ref const BaseTime  preset) GetTime; //x64 ABI OK!

	//Vector					function(const BaseContainer *this_ptr,Int32 id, ref const Vector  preset) GetVector ; //const;
	void						function(const BaseContainer *this_ptr, Vector *result, Int32 id, ref const Vector  preset) GetVector;  //x64 ABI OK!

	//Matrix					function(const BaseContainer *this_ptr,Int32 id, ref const Matrix  preset) GetMatrix ; //const;
	void						function(const BaseContainer *this_ptr, Matrix *result,Int32 id, ref const Matrix  preset) GetMatrix; //x64 ABI OK!

	Int64						function(const BaseContainer *this_ptr,Int32 id, Int64 preset) GetInt64 ; //const;
	void*						function(const BaseContainer *this_ptr,Int32 id, void * preset) GetVoid ; //const;
	const GeData*		        function(const BaseContainer *this_ptr,Int32 id) GetDataPointer ; //const;
	void						function(BaseContainer *this_ptr,ref const BaseContainer  src) Merge;
	UInt32						function(const BaseContainer *this_ptr) GetDirty ; //const;
	void						function(const BaseContainer *this_ptr,const Int32* ids, Int32 cnt, const GeData** data) GetDataPointers ; //const;

	UInt64					    function(const BaseContainer *this_ptr,Int32 id, UInt64 preset) GetUInt64 ; //const;
	UInt32						function(const BaseContainer *this_ptr,Int32 id, UInt32 preset) GetUInt32 ; //const;

	void						function(BaseContainer *this_ptr,Int32 id, UInt64 v) SetUInt64;
	void						function(BaseContainer *this_ptr,Int32 id, UInt32 v) SetUInt32;

	//R15
	void						function(BaseContainer *self, Int32 id, void *mem, Int count) SetMemory;
	void*						function(BaseContainer *self, Int32 id,ref Int count, void* preset) GetMemoryAndRelease;
	void*						function(BaseContainer *self, Int32 id,ref Int count, void* preset) GetMemory; //const;

	void						function(BaseContainer *self, Int32 id,ref const C4DUuid v) SetUuid;
	//? C4DUuid						function(BaseContainer *self, Int32 id,ref const C4DUuid preset) GetUuid; //const;

	//GeDataRef function(BaseContainer *this_ptr, Int32 id) GetDataTest;
	//ref const GeData		function(BaseContainer *this_ptr, Int32 id) GetDataTest;
};

//============================================================================
struct C4D_Uuid
{
nothrow:
@nogc:

	void				function(C4DUuid* uuid) Init;

	Bool				function(C4DUuid *self,ref const C4DUuid uuid2) Compare;// const;

	void				function(C4DUuid *self, UChar* buf) CopyTo;// const;
	void				function(C4DUuid *self, UChar* buf) CopyFrom;

	void				function(C4DUuid *self,ref const C4DUuid dst) CopyToUuid;// const;
	void				function(C4DUuid *self,ref const C4DUuid src) CopyFromUuid;

	Bool				function(C4DUuid *self,ref const String uuid) CopyFromString;

	String				function(C4DUuid *self) GetString;// const;
	UInt32				function(C4DUuid *self) GetHashCode;// const;
};

//============================================================================
struct C4D_GeData
{
nothrow:
@nogc:

	void                        function(GeData *data) Free;
	Bool                        function(const GeData *data,const GeData *data2) IsEqual;
	Int32						function(const GeData *data) GetType;
	void                        function(GeData *dest,const GeData *src,AliasTrans *aliastrans) CopyData;

	Bool						function(GeData *data) SetNil;
	Bool						function(GeData *data,Int32 n) SetInt32;
	Bool						function(GeData *data,Float n) SetFloat;
	Bool						function(GeData *data,ref const Vector  n) SetVector;
	Bool						function(GeData *data,ref const Matrix  n) SetMatrix;
	Bool						function(GeData *data,const String *n) SetString;
	Bool                        function(GeData *data,const Filename *n) SetFilename;
	Bool                        function(GeData *data,ref const BaseTime  n) SetBaseTime;
	Bool                        function(GeData *data,const BaseContainer *n) SetBaseContainer;
	Bool                        function(GeData *data,ref const BaseLink  n) SetLink;

	Int32						function(const GeData *data) GetInt32;
	Float						function(const GeData *data) GetFloat;

	alias ref const Vector		function(const GeData *data)  GetVectorFT;		GetVectorFT	 GetVector;
	alias ref const Matrix 		function(const GeData *data)  GetMatrixFT;		GetMatrixFT	 GetMatrix;
	alias ref const String 		function(const GeData *data)  GetStringFT;		GetStringFT	 GetString;
	alias ref const Filename 	function(const GeData *data)  GetFilenameFT;	GetFilenameFT GetFilename;
	alias ref const BaseTime 	function(const GeData *data)  GetTimeFT;		GetTimeFT	 GetTime;

	BaseContainer*	            function(const GeData *data) GetContainer;
	BaseLink*				    function(const GeData *data) GetLink;

	Bool                        function(GeData *data,Int32 type,ref const CustomDataType  n) SetCustomData;
	CustomDataType*             function(const GeData *data,Int32 type) GetCustomData;
	Bool                        function(GeData *data,Int32 type) InitCustomData;

	Bool						function(GeData *data,Int64 n) SetInt64;
	Int64						function(const GeData *data) GetInt64;
	void 						function(GeData *data, void *v) SetVoid;

	Bool                        function(GeData *data, BaseList2D *bl) SetBlLink;

	//R15 
	void 						function(GeData *data, void *mem, Int count) SetMemory;
	void *						function(GeData *data, ref Int  count) GetMemoryAndRelease;
	void *						function(const GeData *data, ref Int  count) GetMemory;

	Bool						function(GeData *data, const C4DUuid *n) SetUuid;
	/*ref*/ const C4DUuid*		function(const GeData *data) GetUuid; //alias ref const C4DUuid		function(const GeData *data) GetUuidFT;  GetUuidFT GetUuid;

};
static assert(C4D_GeData.sizeof == 35 * (void*).sizeof);
static assert(C4D_GeData.tupleof.length == 35); //we have 35 function pointers

//pragma(msg,C4D_GeData.tupleof.length);
//pragma(msg,typeof(C4D_GeData.tupleof));
//static assert(C4D_GeData.tupleof)


pragma(msg,C4D_String.sizeof/8);

//============================================================================
struct C4D_String
{
nothrow: //does this work ??
@nogc:

	//static if(0) {
	String			*Default; // safety value

	String*			function() Alloc;
	void			function(String *str) Init;
	void			function(String *str) Free;
	void			function(String *str, const(char) *txt, Int32 count, STRINGENCODING type) InitCString;
	void			function(String *str, Int32 count, UInt16 fillchr) InitArray;
	void			function(String *str) Flush;
	void			function(const String *src, String *dst) CopyTo;
	Bool			function(String *dst, const String *src) Add;

	String			function(Float v, Int32 vk, Int32 nk, Bool e, UInt16 xchar) RealToString;
	String			function(Int32 l) LongToString;
	String			function(Int64 l) LLongToString;
	String			function(Int64 l) LLongToStringExEx;

	UInt16			function(const String *str, Int32 pos) GetChr;
	void			function(String *str, Int32 pos, UInt16 chr) SetChr;
	//------------------------------------------------------------------------------------
	Int32			function(const String *this_str) GetLength;//Int32			(String::*GetLength			)() const;

	Bool			function(const String *this_str, ref const String  str, Int32 *pos, Int32 start) FindFirst;
	Bool			function(const String *this_str, ref const String  str, Int32 *pos, Int32 start) FindLast;
	void			function(String *this_str, Int32 pos,Int32 count) Delete;
	void			function(String *this_str, Int32 pos, ref const String  str, Int32 start, Int32 end) Insert;
	String			function(const String *this_str, Int32 start, Int32 count) SubStr;
	Float			function(const String *this_str,Int32 *error, Int32 unit, Int32 angular_type, Int32 base) ParseToFloat;
	Int32			function(const String *this_str,Int32 *error) ParseToInt32;
	String			function(const String *this_str) ToUpper;
	String			function(const String *this_str) ToLower;
	Int32			function(const String *this_str, STRINGENCODING type) GetCStringLen;
	Int32			function(const String *this_str, Char *cstr, Int32 max, STRINGENCODING type) GetCString;
	void			function(const String *this_str, UInt16 *Ubc, Int32 Max) GetUcBlock;
	void			function(const String *this_str, UInt16 *Ubc, Int32 Max) GetUcBlockNull;
	void			function(String *this_str, const UInt16 *Ubc, Int32 Count) SetUcBlock;
	Int32			function(const String *this_str, ref const String  dst) Compare;
	Int32			function(const String *this_str, ref const String  dst) LexCompare;
	Int32			function(const String *this_str, ref const String  dst) RelCompare;
	Int32			function(const String *this_str, ref const String  Str, Int32 cnt, Int32 pos) ComparePart;
	Int32			function(const String *this_str, ref const String  Str, Int32 cnt, Int32 pos) LexComparePart;
	Bool			function(const String *this_str, UInt16 ch, Int32 *Pos, Int32 Start) FindFirstCh;
	Bool			function(const String *this_str, UInt16 ch, Int32 *Pos, Int32 Start) FindLastCh;
	Bool			function(const String *this_str, ref const String  find, Int32 *pos, Int32 start) FindFirstUpper;
	Bool			function(const String *this_str, ref const String  find, Int32 *pos, Int32 start) FindLastUpper;

	//R15
	String			function(Int64 mem) MemoryToString;
	String			function(UInt32 v, Bool prefix0x) HexToString32;
	String			function(UInt64 v, Bool prefix0x) HexToString64;
	String			function(Int64 l) IntToString64;
	String			function(UInt64 l) UIntToString64;
	String			function(Float32 v, Int32 vvk, Int32 nnk, Bool e, UInt16 xchar) FloatToString32;
	String			function(Float64 v, Int32 vvk, Int32 nnk, Bool e, UInt16 xchar) FloatToString64;

	UInt64			function(const String *this_str, Bool* error) ToUInt64;
	UInt32			function(const String *this_str, Bool* error) ToUInt32;
	Int64			function(const String *this_str, Bool* error) ToInt64;
	Int32			function(const String *this_str, Bool* error) ToInt32;

	Float			function(const String *this_str, Bool* error) ToFloat;
}

//============================================================================
struct C4D_Bitmap
{
	BaseBitmap*			        function()Alloc;
	void						function(BaseBitmap *bm)Free;
	BaseBitmap*			        function(const BaseBitmap *src)GetClone;
	Int32						function(const BaseBitmap *bm)GetBw;
	Int32						function(const BaseBitmap *bm)GetBh;
	Int32						function(const BaseBitmap *bm)GetBt;
	Int32						function(const BaseBitmap *bm)GetBpz;
	IMAGERESULT			        function(BaseBitmap *bm, const Filename *name, Int32 frame, Bool *ismovie)Init2;
	void					    function(BaseBitmap *bm)FlushAll;
	IMAGERESULT	                function(const BaseBitmap *self,ref const Filename name, Int32 format, const BaseContainer *data, SAVEBIT savebits) Save;// const;
	void						function(BaseBitmap *bm, Int32 i, Int32 r, Int32 g, Int32 b)SetCMAP;
	void						function(const BaseBitmap *src, BaseBitmap *dst, Int32 intens, Bool sample, Bool nprop)ScaleIt;
	void						function(BaseBitmap *bm, Int32 r, Int32 g, Int32 b)SetPen;
	void						function(BaseBitmap *bm, Int32 x1, Int32 y1, Int32 x2, Int32 y2, Int32 r, Int32 g, Int32 b)Clear;
	void						function(BaseBitmap *bm, Int32 x1, Int32 y1, Int32 x2, Int32 y2)Line;
	void						function(const BaseBitmap *bm, Int32 x, Int32 y, UInt16 *r, UInt16 *g, UInt16 *b)GetPixel;
	BaseBitmap *		        function(BaseBitmap *bm, Bool internal, Bool straight)AddChannel;
	void						function(BaseBitmap *bm, BaseBitmap *channel)RemoveChannel;
	void						function(const BaseBitmap *bm, BaseBitmap *channel, Int32 x, Int32 y, UInt16 *val)GetAlphaPixel;
	BaseBitmap *		        function(BaseBitmap *bm)GetInternalChannel;
	Int32						function(const BaseBitmap *bm)GetChannelCount;
	BaseBitmap *		        function(const BaseBitmap *bm, Int32 num) GetChannelNum;
	BaseBitmap*			        function(const BaseBitmap *src, Int32 x, Int32 y, Int32 w, Int32 h)GetClonePart;
	Bool						function(const BaseBitmap *src, BaseBitmap *dst)CopyTo;
	void						function(const BaseBitmap *src, BaseBitmap *dest, Int32 src_xmin, Int32 src_ymin, Int32 src_xmax, Int32 src_ymax, Int32 dst_xmin, Int32 dst_ymin, Int32 dst_xmax, Int32 dst_ymax)ScaleBicubic;
	BaseBitmap*			        function(const BaseBitmap *bm, BaseBitmap *channel)GetAlphaBitmap;

	Bool						function(const BaseBitmap *bm)IsMultipassBitmap;

	MultipassBitmap*            function(Int32 bx, Int32 by, COLORMODE mode)MPB_AllocWrapperPB;
	MultipassBitmap*            function(BaseBitmap *bmp)MPB_AllocWrapper;
	PaintBitmap*		        function(MultipassBitmap *mp)MPB_GetPaintBitmap;
	Int32						function(const MultipassBitmap *mp)MPB_GetLayerCount;
	Int32						function(const MultipassBitmap *mp)MPB_GetAlphaLayerCount;
	Int32						function(const MultipassBitmap *mp)MPB_GetHiddenLayerCount;
	MultipassBitmap*            function(MultipassBitmap *mp,Int32 num)MPB_GetLayerNum;
	MultipassBitmap*            function(MultipassBitmap *mp,Int32 num)MPB_GetAlphaLayerNum;
	MultipassBitmap*            function(MultipassBitmap *mp,Int32 num)MPB_GetHiddenLayerNum;
	MultipassBitmap*            function(MultipassBitmap *mp,MultipassBitmap *insertafter,COLORMODE colormode,Bool hidden)MPB_AddLayer;
	MultipassBitmap*            function(MultipassBitmap *mp,MultipassBitmap *insertafter,Bool hidden)MPB_AddFolder;
	MultipassBitmap*            function(MultipassBitmap *mp,MultipassBitmap *insertafter,COLORMODE colormode)MPB_AddAlpha;
	Bool						function(MultipassBitmap *mp,MultipassBitmap *layer)MPB_DeleteLayer;
	MultipassBitmap*            function(MultipassBitmap *mp,Int32 id,Int32 subid)MPB_FindUserID;
	void						function(MultipassBitmap *mp)MPB_ClearImageData;
	void						function(MultipassBitmap *mp, BaseBitmap *master)MPB_SetMasterAlpha;

	//GeData					function(const MultipassBitmap *mp, MPBTYPE id)MPB_GetParameter;
	void					    function(GeData *result,const MultipassBitmap *mp, MPBTYPE id)MPB_GetParameter; //TODO 

	Bool						function(MultipassBitmap *mp, MPBTYPE id,ref const GeData  par)MPB_SetParameter;

	UInt32						function(const BaseBitmap *bm)GetDirty;

	void						function(const BaseBitmap *bm, Int32 x, Int32 y, Int32 cnt, UChar *buffer, Int32 inc, COLORMODE dstmode, PIXELCNT flags, ColorProfileConvert *conversion)GetPixelCnt;
	//GeData					    function(const BaseBitmap *bm, Int32 id, ref const GeData  t_default)GetBaseBitmapData;
	void					    function(GeData *result, const BaseBitmap *bm, Int32 id, ref const GeData  t_default)GetBaseBitmapData;

	Bool						function(BaseBitmap *bm, Int32 id, ref const GeData  data)SetBaseBitmapData;

	void						function(BaseBitmap *bm)SetDirty;
	Bool						function(const BaseBitmap *src, BaseBitmap *dst, Int32 x, Int32 y, Int32 w, Int32 h)CopyPartTo;

	BaseBitmapLink *            function()BBL_Alloc;
	void						function(BaseBitmapLink *link)BBL_Free;
	BaseBitmap *                function(BaseBitmapLink *link)BBL_Get;
	void						function(BaseBitmapLink *link, BaseBitmap *bmp)BBL_Set;

	Int                         function(const BaseBitmap *bmp)GetMemoryInfo;
	Int32						function(const MultipassBitmap *mp)MPB_GetEnabledLayerCount;
	Bool						function(MultipassBitmap *mp, MPB_GETLAYERS flags, ref BaseBitmap ** list, ref Int32  count)MPB_GetLayers;
	UChar*					    function(BaseBitmap *bm)GetDrawPortBits;
	Bool						function(const BaseBitmap *mp, ref BaseContainer  regions)GetUpdateRegions;
	IMAGERESULT			        function(BaseBitmap *bm, Int32 x, Int32 y, Int32 depth, INITBITMAPFLAGS flags)Init1;
	Bool						function(BaseBitmap *bm, Int32 id, Int32 type, Int32 xmin, Int32 xmax, Int32 ymin, Int32 ymax)AddUpdateRegion;
	Bool						function(BaseBitmap *bm, Int32 id)RemoveUpdateRegion;
	BaseBitmap*			        function(const BaseBitmap *bm)GetUpdateRegionBitmap;
	IMAGERESULT			        function(ref BaseBitmap * bm, ref const Filename  name, Int32 frame, Bool *ismovie, BitmapLoaderPlugin **loaderplugin)Init3;
	MultipassBitmap*            function(MultipassBitmap *mp)MPB_GetSelectedLayer;
	Bool						function(BaseBitmap *bm, Int32 x, Int32 y, Int32 cnt, UChar *buffer, Int32 inc, COLORMODE srcmode, PIXELCNT flags)SetPixelCnt;
	Bool						function(BaseBitmap *bm, Int32 x, Int32 y, Int32 r, Int32 g, Int32 b)SetPixel;
	Bool						function(BaseBitmap *bm, BaseBitmap *channel, Int32 x, Int32 y, Int32 val)SetAlphaPixel;
	void						function(MultipassBitmap *mp)MPB_FreeHiddenLayers;
	Bool						function(BaseBitmap *bm, const ColorProfile *profile)SetColorProfile;
	const ColorProfile*         function(const BaseBitmap *bm)GetColorProfile;

	ColorProfile*		        function()ProfileAlloc;
	void						function(ColorProfile *profile)ProfileFree;
	Bool						function(const ColorProfile *src, ColorProfile *dst)ProfileCopy;
	Bool						function(const ColorProfile *src, const ColorProfile *dst)ProfileEqual;
	const ColorProfile *        function()ProfileSRGB;
	const ColorProfile *        function()ProfileLinearRGB;
	Bool						function(ColorProfile *profile, CDialog *dlg)ProfileWindow;
	Bool						function(ColorProfile *profile, ref const Filename  fn)ProfileFromFile;
	Bool						function(ColorProfile *profile, const(void) *mem, Int64 memsize)ProfileFromMemory;
	Bool						function(const ColorProfile *profile, ref void * mem, ref Int64  memsize)ProfileToMemory;
	Bool						function(const ColorProfile *profile, ref const Filename  fn)ProfileToFile;
	//String					    function(const ColorProfile *profile, Int32 info)ProfileInfo;
	void					    function(String result, const ColorProfile *profile, Int32 info)ProfileInfo; //TODO 

	Bool						function(const ColorProfile *profile)ProfileIsMonitorMode;
	Bool						function(const ColorProfile *profile)ProfileHasProfile;
	Bool						function(ColorProfile *profile, Bool on)ProfileSetMonitorMode;

	ColorProfileConvert*        function()ProfileConvAlloc;
	void						function(ColorProfileConvert *profile)ProfileConvFree;
	Bool						function(ColorProfileConvert *profile, COLORMODE srccolormode, const ColorProfile *srcprofile, COLORMODE dstcolormode, const ColorProfile *dstprofile, Bool bgr)ProfileConvTransform;
	void						function(const ColorProfileConvert *profile, const PIX *src, PIX *dst, Int32 cnt, Int32 SkipInputComponents, Int32 SkipOutputComponents)ProfileConvConvert;
	Bool						function(const ColorProfile *profile, COLORMODE colormode)ProfileCheckColorMode;
	const ColorProfile *        function()ProfileSGray;
	const ColorProfile *        function()ProfileLinearGray;
	Bool						function(MultipassBitmap *self, const ColorProfile *profile, Bool dithering) SetTempColorProfile;
	Int32						function(MultipassBitmap *self) GetUserID;// const;

	void						function(BaseBitmap *bm, Int32 x, Int32 y, Float radius, Float angle_start, Float angle_end, Int32 subdiv)Arc;

static if(API_VERSION >= 15000) { //R15 only

	void						function(MultipassBitmap *self, Int32 id) SetUserID;
	void						function(MultipassBitmap *self, Int32 subid) SetUserSubID;
	void						function(MultipassBitmap *self, Bool save) SetSave;
	void						function(MultipassBitmap *self, Int32 mode) SetBlendMode;
	void						function(MultipassBitmap *self, ref const String name) SetName;
	void						function(MultipassBitmap *self, COLORMODE mode) SetColorMode;
	void						function(MultipassBitmap *self, Int32 c) SetComponent;
	void						function(MultipassBitmap *self, Int32 dpi) SetDpi;

	//String					    function(Int32 id, Int32 subid, String *suggestion)MPB_GetPassName;
	void					    function(String result, Int32 id, Int32 subid, String *suggestion) MPB_GetPassName; //TODO
	Bool						function(MultipassBitmap* mp, BaseBitmap *bmp)MPB_SetResultBitmap;
} //R15

}; //C4D_Bitmap

//=============================================================================
struct C4D_MovieSaver
{
	MovieSaver*			function()Alloc;
	void				function(MovieSaver *ms)Free;
	IMAGERESULT			function(MovieSaver *ms, BaseBitmap *bm)Write;
	void				function(MovieSaver *ms)Close;
	Bool				function(MovieSaver *ms, Int32 id, BaseContainer *bc)Choose;
	IMAGERESULT			function(MovieSaver *ms, const Filename *name, BaseBitmap *bm, Int32 fps, Int32 id, const BaseContainer *data, SAVEBIT savebits,BaseSound *sound)Open;
};



//=============================================================================
struct C4D_BaseChannel
{
	BaseChannel*		function()Alloc;
	void				function(BaseChannel *bc)Free;
	Bool				function(BaseChannel *bc1,BaseChannel *bc2)Compare;
	INITRENDERRESULT	function(BaseChannel *bc, ref const InitRenderStruct  irs)InitTexture;
	void				function(BaseChannel *bc)FreeTexture;
	Vector				function(BaseChannel *bc, VolumeData *vd, Vector *p, Vector *delta, Vector *n, Float t, Int32 tflag, Float off, Float scale)BcSample;
	BaseBitmap*			function(BaseChannel *bc)BCGetBitmap;
	void				function(BaseChannel *bc, BaseContainer *ct)GetData;
	void				function(BaseChannel *bc, const BaseContainer *ct)SetData;
	Bool				function(HyperFile *hf, BaseChannel *bc)ReadData;
	Bool				function(HyperFile *hf, BaseChannel *bc)WriteData;

	Int32				function(BaseChannel *bc)GetPluginID;
	BaseShader*		    function(BaseChannel *bc)GetPluginShader;

	Bool				function(BaseChannel *bc, GeListNode *element)Attach;

	Bool				function(ref const BaseContainer  bc, ref const DescID  descid, Int32 value, Int param)HandleShaderPopup;
	Bool				function(BaseList2D *parent, ref BaseShader * current, Int32 value, Int param)HandleShaderPopupI;
	Bool				function(BaseContainer *menu, ref const BaseContainer  bc, ref const DescID  descid, Int param)BuildShaderPopupMenu;
	Bool				function(BaseContainer *menu, BaseList2D *parent, BaseShader *current, Int param)BuildShaderPopupMenuI;

	void				function(GeListNode *node, BaseShader *ps, Int32 type, void *data)HandleShaderMessage;
	Bool                function(GeListNode *node, Int32 id, HyperFile *hf)ReadDataConvert;

	INITRENDERRESULT	function(BaseShader *self,ref const InitRenderStruct irs) InitRender;
	void				function(BaseShader *self) FreeRender;
	Vector				function(BaseShader *self, ChannelData *vd) Sample;
	Vector				function(BaseShader *self, ChannelData *vd, SAMPLEBUMP bumpflags) SampleBump;
	BaseBitmap*			function(BaseShader *self) GetBitmap;
	SHADERINFO			function(BaseShader *self) GetRenderInfo;

	BaseShader*			function(Int32 type)PsAlloc;
	Bool				function(BaseShader *self, BaseShader* dst) PsCompare;

	String				function(Int32 channelid)GetChannelName;
	GL_MESSAGE			function(BaseShader *self, Int32 type, void *data) GlMessage;
	Bool				function(BaseShader *self, BaseDocument *doc) IsColorManagementOff;
	void				function(BaseShader *self, BaseDocument* doc) DestroyGLImage;
	void				function(BaseShader *self, BaseDocument* doc) InvalidateGLImage;
	BaseShader*			function(BaseShader *self, ref Float bestmpl) GetSubsurfaceShader;
};

//=============================================================================
struct C4D_Filename
{
nothrow:
@nogc:

	Filename				*Default; // safety value

	Filename*				function() Alloc;
	Filename*				function(const Filename *fn) GetClone;
	void					function(Filename *fn) Free;
	Bool					function(Filename *this_ptr,FILESELECTTYPE type, FILESELECT flags, ref const String  title, ref const String  force_suffix) FileSelect;//MFP
	Bool					function(const Filename *fn) Content;
	const String			function(const Filename *fn) GetString;
	void					function(Filename *fn, const String *str) SetString;
	const Filename			function(const Filename *fn) GetDirectory;
	const Filename			function(const Filename *fn) GetFile;
	void					function(Filename *fn) ClearSuffix;
	void					function(Filename *fn, const String *str) SetSuffix;
	Bool					function(const Filename *fn, const String *str) CheckSuffix;
	void					function(Filename *fn, const Filename *str) SetDirectory;
	void					function(Filename *fn, const Filename *str) SetFile;
	Bool					function(const Filename *fn1, const Filename *fn2) Compare;
	void					function(Filename *dst, const Filename *src) Add;

	void					function(Filename *fn) Init;
	void					function(Filename *fn) Flush;
	void					function(const Filename *src, Filename *dst) CopyTo;
	void					function(Filename *fn, void *adr, Int size) SetMemoryReadMode;
	void					function(Filename *fn, MemoryFileStruct *mfs) SetMemoryWriteMode;

	MemoryFileStruct*		function() MemoryFileStructAlloc;
	void					function(ref MemoryFileStruct * mfs) MemoryFileStructFree;
	void					function(MemoryFileStruct *mfs, ref void * data, ref Int size, Bool release) MemoryFileStructGetData;
	void					function(Filename *fn, const Char *str) SetCString;
	void					function(Filename *fn) ClearSuffixComplete;

	void					function(Filename *this_ptr,IpConnection *ipc) SetIpConnection;
	IpConnection*			function(const Filename *this_ptr) GetIpConnection ; //const;

	const String			function(const Filename *fn) GetSuffix;

	//R15
	Bool					function(Filename self) IsBrowserUrl;// const;
};

//=============================================================================
struct C4D_BrowseFiles
{
nothrow:
@nogc:
	BrowseFiles*		function(const Filename *dir, Int32 flags)Alloc;
	void				function(BrowseFiles *bf)Free;
	void				function(BrowseFiles *bf, const Filename *dir, Int32 flags)Init;

	Bool				function(BrowseFiles *self ) GetNext;
	Filename			function(BrowseFiles *self ) GetFilename;
	Bool				function(BrowseFiles *self ) IsDir;
	Int64				function(BrowseFiles *self ) GetSize;
	void				function(BrowseFiles *self, Int32 mode, LocalFileTime *lft_out) GetFileTime;
	Bool				function(BrowseFiles *self ) IsHidden;
	Bool				function(BrowseFiles *self ) IsReadOnly;
	Bool				function(BrowseFiles *self ) IsBundle;

	BrowseVolumes*		function()BvAlloc;
	void				function(BrowseVolumes *bv)BvFree;
	void				function(BrowseVolumes *self ) BvInit;
	Bool				function(BrowseVolumes *self ) BvGetNext;
	Filename			function(BrowseVolumes *self ) BvGetFilename;
	String				function(BrowseVolumes *self,  Int32 *out_flags) BvGetVolumeName;
};

//=============================================================================
struct C4D_File
{
nothrow:
@nogc:

	BaseFile*			function()Alloc;
	void				function(BaseFile *fl)Free;
	AESFile*			function()AESAlloc;
	Bool				function(ref const Filename  encrypt, ref const Filename  decrypt, const(char) * key, Int32 keylen, Int32 blocksize)AESCheckEncryption;

	Bool				function(BaseFile *self, ref const Filename name, FILEOPEN mode, FILEDIALOG error_dialog, BYTEORDER order, Int32 type, Int32 creator) Open;
	Bool				function(BaseFile *self,) Close;
	void				function(BaseFile *self, BYTEORDER order) SetOrder;
	Int					function(BaseFile *self, void *data, Int len, Bool just_try_it) ReadBytes;
	Bool				function(BaseFile *self, const void *data, Int len) WriteBytes;
	Bool				function(BaseFile *self, Int64 pos, FILESEEK mode) Seek;
	Int64				function(BaseFile *self,) GetPosition;
	Int64				function(BaseFile *self,) GetLength;
	FILEERROR			function(const BaseFile *self) GetError;// const;
	void				function(BaseFile *self, FILEERROR error) SetError;
	Bool				function(BaseFile *self, Char  v) WriteChar;
	Bool				function(BaseFile *self, UChar v) WriteUChar;
	Bool				function(BaseFile *self, Int16  v) WriteInt16;
	Bool				function(BaseFile *self, UInt16 v) WriteUInt16;
	Bool				function(BaseFile *self, Int32  v) WriteInt32;
	Bool				function(BaseFile *self, UInt32 v) WriteUInt32;
	Bool				function(BaseFile *self, Float32 v) WriteFloat32;
	Bool				function(BaseFile *self, Float64 v) WriteFloat64;
	Bool				function(BaseFile *self, Char  *v) ReadChar;
	Bool				function(BaseFile *self, UChar *v) ReadUChar;
	Bool				function(BaseFile *self, Int16  *v) ReadInt16;
	Bool				function(BaseFile *self, UInt16 *v) ReadUInt16;
	Bool				function(BaseFile *self, Int32  *v) ReadInt32;
	Bool				function(BaseFile *self, UInt32 *v) ReadUInt32;
	Bool				function(BaseFile *self, Float32 *v) ReadFloat32;
	Bool				function(BaseFile *self, Float64 *v) ReadFloat64;
	Bool				function(BaseFile *self, Int64 *v) ReadInt64;
	Bool				function(BaseFile *self, Int64 v) WriteInt64;

	Bool				function(AESFile *self, ref const Filename name, const char* key, Int32 keylen, Int32 blocksize, UInt32 aes_flags, FILEOPEN mode, FILEDIALOG error_dialog, BYTEORDER order, Int32 type, Int32 creator) AESOpen;
	Bool				function(BaseFile *self, UInt64 *v) ReadUInt64;
	Bool				function(BaseFile *self, UInt64 v) WriteUInt64;
	LOCATION			function(const BaseFile *self) GetLocation;// const;
};

import c4d_gui : GeDialog, GeUserArea;

//=============================================================================
struct C4D_Dialog
{
nothrow:
@nogc:

	CDialog*		function(CDialogMessage *dlgfunc, /*void **/GeDialog userdata)Alloc;
	void			function(CDialog *cd)Free;
	void *			function(CDialog *cd)GetUserData;
	Bool			function(CDialog *cd)Close;
	Bool			function(CDialog *cd, Int32 id, Bool enabled, void *gadptr)Enable;
	void			function(CDialog *cd, Int32 timer)SetTimer;
	Bool			function(CDialog *cd, Int32 id, Int32 value, Int32 min, Int32 max, Int32 step, void *gadptr)SetInt32;
	Bool			function(CDialog *cd, Int32 id, Float value, Float min, Float max, Float step, Int32 format, void *gadptr)SetFloat;
	Bool			function(CDialog *cd, Int32 id, ref const Vector  value, void *gadptr)SetVector;
	Bool			function(CDialog *cd, Int32 id, const String *text, void *gadptr)SetString;
	Bool			function(CDialog *cd, Int32 id, ref const Vector  color, Float brightness, Float maxbrightness, Int32 flags, void *gadptr)SetColorField;
	Bool			function(CDialog *cd, Int32 id, ref Int32  value, void *gadptr)GetInt32;
	Bool			function(CDialog *cd, Int32 id, ref Float  value, void *gadptr)GetFloat;
	Bool			function(CDialog *cd, Int32 id, ref Vector  value, void *gadptr)GetVector;
	Bool			function(CDialog *cd, Int32 id, ref String * text, void *gadptr)GetString;
	Bool			function(CDialog *cd, Int32 id, ref Vector  color, ref Float  brightness, void *gadptr)GetColorField;
	Bool			function(CDialog *cd, Int32 id, LocalResource *lr, Int32 flags)LoadDialogResource;
	Bool			function(CDialog *cd, Int32 id, Int32 flags, Int32 tabtype)TabGroupBegin;
	Bool			function(CDialog *cd, Int32 id, Int32 flags, Int32 cols, Int32 rows, const String *title, Int32 groupflags)GroupBeginEx;
	Bool			function(CDialog *cd, Int32 spacex, Int32 spacey)GroupSpace;
	Bool			function(CDialog *cd, UInt32 borderstyle)GroupBorder;
	Bool			function(CDialog *cd, Int32 left, Int32 top, Int32 right, Int32 bottom)GroupBorderSize;
	Bool			function(CDialog *cd)GroupEnd;
	Bool			function(CDialog *cd, Int32 id, const BaseContainer *bc, void *gadptr)SetPopup;
	Bool			function(CDialog *cd, Int32 *x, Int32 *y)Screen2Local;
	Bool			function(CDialog *cd, Int32 scrollgroupid, Int32 x1, Int32 y1, Int32 x2, Int32 y2)SetVisibleArea;
	Bool			function(CDialog *cd, Int32 id, Int32 *x, Int32 *y, Int32 *w, Int32 *h, void *gadptr)GetItemDim;
	Bool			function(CDialog *cd, Int32 id)SendRedrawThread;
	Bool            function(CDialog *cd, Int32 id, Int32 *x1, Int32 *y1, Int32 *x2, Int32 *y2)GetVisibleArea;
	Bool			function(CDialog *cd, void *secret)RestoreLayout;
	Bool			function(CDialog *cd, const BaseContainer *result)SetMessageResult;

	Bool            function(CDialog *cd, Int32 cursor)SetDragDestination;
	Bool			function(CDialog *parentcd, Int32 id, CDialog *cd)AttachSubDialog;
	Int32			function(CDialog *cu)GetID;
	void *			function(CDialog *cd, Int32 id)FindCustomGui;
	Bool			function(CDialog *cd, Int32 type, Int32 id, const String *name, Int32 par1, Int32 par2, Int32 par3, Int32 par4, const BaseContainer *customdata, void **resptr)AddGadget;
	Bool			function(CDialog *cd)ReleaseLink;
	Bool			function(CDialog *cd, const BaseContainer *msg)SendParentMessage;

	Bool			function(CDialog *cd, DLG_TYPE dlgtype, CDialog *parent, Int32 xpos, Int32 ypos, Int32 defaultw, Int32 defaulth)Open;
	CUserArea*		function(CDialog *cd, Int32 id, /*void **/ GeUserArea userdata, USERAREAFLAGS userareaflags, void *gadptr)AttachUserArea;
	Bool            function(CDialog *cd, const BaseContainer *msg, Int32 *type, void **object)GetDragObject;

	LassoSelection*	function()LSAlloc;
	void			function(LassoSelection *ls)LSFree;
	Int32			function(LassoSelection *ls)LSGetMode;
	Bool			function(LassoSelection *ls, Int32 x, Int32 y)LSTest;
	Bool			function(LassoSelection *ls)LSCheckSingleClick;
	Bool			function(LassoSelection *ls, CBaseFrame *cd, Int32 mode, Int32 start_x, Int32 start_y, Int32 start_button, Int32 sx1, Int32 sy1, Int32 sx2, Int32 sy2)LSStart;
	Bool			function(LassoSelection *ls, ref const Vector  pa, ref const Vector  pb, ref const Vector  pc, ref const Vector  pd)LSTestPolygon;

	CBaseFrame*		function(CDialog *cd, Int32 id)CBF_FindBaseFrame;
	Bool			function(CBaseFrame *cbf, Int32 cursor)CBF_SetDragDestination;
	void *			function(CBaseFrame *cbf)CBF_GetWindowHandle;
	GeData			function(CDialog *cd, Int32 id, BaseContainer *msg, void *gadptr)SendUserAreaMessage;
	Bool			function(LassoSelection *ls, ref Float  x1, ref Float  y1, ref Float  x2, ref Float  y2)LSGetRectangle;
	Bool			function(CBaseFrame *cbf, Int32 colorid, ref Int32  r, ref Int32  g, ref Int32  b)CBF_GetColorRGB;
	Bool			function(LASTCURSORINFOFUNC func)RemoveLastCursorInfo;
	String			function(Int32 shortqual, Int32 shortkey)Shortcut2String;

	Bool			function(ref Int32  id, const Char* ident)GetIconCoordInfo;
	Bool			function(Int32 type, Int32 id_x, Int32 id_y, Int32 id_w, Int32 id_h, ref IconData  d)GetInterfaceIcon;
	Bool			function(CDialog *cd, Int32 id, void *gadptr)IsEnabled;
	GeClipMap*		function(Int32 type)GetInterfaceScheme;
	Bool			function(CDialog *cd, Int32 id, Int32 flags, Int32 cols, Int32 rows, const String *title, Int32 groupflags, Int32 minx, Int32 miny)GroupBegin;
	void			function(CBaseFrame *cbf, Int32 milliseconds)CBF_ActivateFading;
	void			function(CBaseFrame *cbf, Int32 colorid, Int32 highlightid, Float percent)CBF_AdjustColor;
};

//=============================================================================
struct C4D_UserArea
{
nothrow:
@nogc:

	void						function(CUserArea* cu)Free;
	void *						function(CUserArea *cu)GetUserData;
	Int32						function(CUserArea *cu)GetWidth;
	Int32						function(CUserArea *cu)GetHeight;
	Int32						function(CUserArea *cu)GetID;
	void						function(CUserArea *cu, Int32 w, Int32 h)SetMinSize;
	void						function(CUserArea *cu, Int32 x1, Int32 y1, Int32 x2, Int32 y2)DrawLine;
	void						function(CUserArea *cu, Int32 x1, Int32 y1, Int32 x2, Int32 y2)DrawRectangle;
	void						function(CUserArea *cu, ref const Vector  color)DrawSetPenV;
	void						function(CUserArea *cu, Int32 id)DrawSetPenI;
	void						function(CUserArea *cu, Int32 timer)SetTimer;
	Bool						function(CBaseFrame *cu, Int32 askdevice, Int32 askchannel, BaseContainer *res)GetInputState;
	Bool						function(CBaseFrame *cu, Int32 askdevice, BaseContainer *res)GetInputEvent;
	void						function(CBaseFrame *cu)KillEvents;
	void						function(CUserArea *cu, Int32 fontid)DrawSetFont;
	Int32						function(CUserArea *cu, const String *text)DrawGetTextWidth;
	Int32						function(CUserArea *cu)DrawGetFontHeight;
	void						function(CUserArea *cu, Int32 fg, Int32 bg)DrawSetTextColII;
	void						function(CUserArea *cu, ref const Vector  fg, Int32 bg)DrawSetTextColVI;
	void						function(CUserArea *cu, Int32 fg, ref const Vector  bg)DrawSetTextColIV;
	void						function(CUserArea *cu, ref const Vector  fg, ref const Vector  bg)DrawSetTextColVV;
	void						function(CUserArea *cu, BaseBitmap *bmp, Int32 wx, Int32 wy, Int32 ww, Int32 wh, Int32 x, Int32 y, Int32 w, Int32 h, Int32 mode)DrawBitmap;
	void						function(CUserArea *cu, Int32 x, Int32 y, Int32 w, Int32 h)SetClippingRegion;
	void						function(CUserArea *cu, Int32 xdiff, Int32 ydiff, Int32 x, Int32 y, Int32 w, Int32 h)ScrollArea;
	void						function(CUserArea *cu)ClearClippingRegion;
	Bool						function(CUserArea *cu)OffScreenOn;

	Bool						function(CBaseFrame *cu, Int32 *x, Int32 *y)Global2Local;
	Bool						function(CUserArea *cu, const BaseContainer *msg)SendParentMessage;

	Bool						function(CBaseFrame *cu, Int32 *x, Int32 *y)Screen2Local;
	Bool                        function(CUserArea *cu, Int32 cursor)SetDragDestination;
	Bool                        function(CUserArea *cu, const BaseContainer *msg, Int32 type, void *data, Int32 dragflags)HandleMouseDrag;
	Bool						function(CUserArea *cu)IsEnabled;

	void						function(CUserArea *cu, Int32 type, Int32 *l, Int32 *t, Int32 *r, Int32 *b)GetBorderSize;
	void                        function(CUserArea *cu, Int32 type, Int32 x1, Int32 y1, Int32 x2, Int32 y2)DrawBorder;


	_GeListView*		        function()GeListView_Alloc;
	void						function(_GeListView *lv)GeListView_Free;
	Bool                        function(_GeListView *lv, CDialog *cd, Int32 id, ListViewCallBack *callback, /*GeListView*/ void *userdata)GeListView_Attach;
	void                        function(_GeListView *lv, ref Int32  res_type, ref void * result, void *secret, Int32 cmd, Int32 line, Int32 col)GeListView_LvSuperCall;
	void                        function(_GeListView *lv)GeListView_Redraw;
	void                        function(_GeListView *lv)GeListView_DataChanged;
	Bool                        function(_GeListView *lv, void *secret, ref MouseDownInfo  info, Int32 size)GeListView_ExtractMouseInfo;
	Bool                        function(_GeListView *lv, void *secret, ref DrawInfo  info, Int32 size)GeListView_ExtractDrawInfo;
	Bool                        function(_GeListView *lv, const BaseContainer *msg)GeListView_SendParentMessage;
	Int32						function(_GeListView *lv)GeListView_GetId;
	void						function(_GeListView *lv, Int32 line, Int32 col)GeListView_ShowCell;

	_SimpleListView*            function()SimpleListView_Alloc;
	void                        function(_SimpleListView *lv)SimpleListView_Free;
	Bool                        function(_SimpleListView *lv, Int32 columns, ref const BaseContainer  data)SimpleListView_SetLayout;
	Bool                        function(_SimpleListView *lv, Int32 id, ref const BaseContainer  data)SimpleListView_SetItem;
	Bool                        function(_SimpleListView *lv, Int32 id, BaseContainer *data)SimpleListView_GetItem;
	Int32                       function(_SimpleListView *lv)SimpleListView_GetItemCount;
	Bool                        function(_SimpleListView *lv, Int32 num, Int32 *id, BaseContainer *data)SimpleListView_GetItemLine;
	Bool                        function(_SimpleListView *lv, Int32 id)SimpleListView_RemoveItem;
	Int32                       function(_SimpleListView *lv, BaseSelect *selection)SimpleListView_GetSelection;
	Bool                        function(_SimpleListView *lv, BaseSelect *selection)SimpleListView_SetSelection;
	void                        function(_SimpleListView *lv, Int32 line, Int32 col)SimpleListView_ShowCell;

	Int32                       function(_SimpleListView *lv, Int32 id)SimpleListView_GetProperty;
	Bool                        function(_SimpleListView *lv, Int32 id, Int32 val)SimpleListView_SetProperty;

	Bool						function(CUserArea *cu, Int32 id)IsHotkeyDown;
	Bool						function(CUserArea *cu)HasFocus;

	void						function(CUserArea *cu, Int32 Button, Float mx, Float my, MOUSEDRAGFLAGS flag)MouseDragStart;
	MOUSEDRAGRESULT             function(CUserArea *cu, Float *mx, Float *my, BaseContainer *channels)MouseDrag;
	MOUSEDRAGRESULT             function(CUserArea *cu)MouseDragEnd;
	Int32						function(CUserArea *cu, BaseList2D *node, Int32 fontid)DrawGetTextWidth_ListNodeName;
	Bool						function(CUserArea *cu, Int32 x, Int32 y, Int32 w, Int32 h)OffScreenOnRect;
	void						function(CUserArea *cu, ref const String  txt, Int32 x, Int32 y, Int32 flags)DrawText;
	void						function(CUserArea *cu, Float textrotation)DrawSetTextRotation;
	Int32						function(CUserArea *cu)DrawGetFontBaseLine;
	Bool						function(CBaseFrame *cu, Int32 *x, Int32 *y)Local2Global;
	Bool						function(CBaseFrame *cu, Int32 *x, Int32 *y)Local2Screen;
	void						function(CUserArea *cu, Float sx, Float sy, Float *p, Int32 count, Bool closed, Bool filled)DrawBezier;
	Bool						function(CUserArea *cu)IsR2L;

static if(API_VERSION >= 15000) { //R15 only
	Float						function(const CBaseFrame *cu)GetPixelRatio;
} //R15 only


};


//=============================================================================
struct C4D_Parser
{
nothrow:
@nogc:

	Parser*				function()Alloc;
	void				function(Parser *pr)Free;
	Bool				function(Parser *pr, const String *str, Int32 *error,Float *res,Int32 unit,Int32 angletype,Int32 basis)Eval;
	Bool				function(Parser *pr, const String *str, Int32 *error,Int32 *res,Int32 unit,Int32 basis)EvalLong;
	Bool				function(Parser *pr, const String *str, Float *value, Bool case_sensitive)AddVar;
	Bool				function(Parser *pr, const String *str, Int32 *value, Bool case_sensitive)AddVarLong;
	Bool				function(Parser *pr, const String *s, Bool case_sensitive)RemoveVar;
	Bool				function(Parser *pr)RemoveAllVars;
	void				function(Parser *pr, ParserCache *p)GetParserData;
	Bool				function(Parser *pr, const String *s, Int32 *error, Int32 unit, Int32 angle_unit, Int32 base)Init;
	Bool				function(Parser *pr, Float *result, Int32 *error)ReEval;
	Bool				function(Parser *pr, const ParserCache *pdat, Float *result, Int32 *error)Calculate;
	Bool				function(Parser *pr, Int32 *result, Int32 *error)ReEvalLong;
	Bool				function(Parser *pr, const ParserCache *pdat, Int32 *result, Int32 *error)CalculateLong;
	Bool				function(Parser *pr, ParserCache *p)Reset;
	ParserCache*		function()AllocPCache;
	void				function(ParserCache *p)FreePCache;
	Bool				function(ParserCache *p, ParserCache *d)CopyPCache;
};

//=============================================================================
struct C4D_Resource
{
nothrow:
@nogc:

	LocalResource*	        function(const Filename *path)Alloc;
	void					function(LocalResource *lr)FreeEx;
	LocalResource*          function()GetCinemaResource;
	/*ref*/ const String *		function(LocalResource *lr,Int32 id)LoadString; //ref problem

	BaseContainer*	        function(ref const String  menuname)GetMenuResource;
	void					function()UpdateMenus;
	Bool					function(LocalResource *lr,const Filename *path)ReloadResource;

	void					function(LocalResource *lr, Bool regardIsStopped)Free;
};

//=============================================================================
struct C4D_Atom
{
nothrow:
@nogc:

	C4DAtom*				    function(C4DAtom *self, COPYFLAGS flags, AliasTrans *trn) GetClone;
	Bool						function(C4DAtom *self, C4DAtom *dst, COPYFLAGS flags, AliasTrans *trn) CopyTo;
	Int32						function(const C4DAtom *self ) GetType;// const;
	Bool						function(const C4DAtom *self, Int32 id) IsInstanceOf;// const;
	Bool						function(C4DAtom *self, Int32 type, void *data) Message;
	Bool						function(C4DAtom *self, MULTIMSG_ROUTE flags, Int32 type, void *data) MultiMessage;
	Bool                        function(C4DAtom *self, ref Description res,DESCFLAGS_DESC flags) GetDescription;
	Bool                        function(C4DAtom *self, ref const DescID id,ref GeData t_data,DESCFLAGS_GET flags) GetParameter;
	Bool                        function(C4DAtom *self, ref const DescID id,ref const GeData t_data,DESCFLAGS_SET flags) SetParameter;
	DynamicDescription*		    function(C4DAtom *self,) GetDynamicDescription;

	GeListNode*			        function(const GeListNode *self ) GetNext;// const;
	GeListNode*			        function(const GeListNode *self ) GetPred;// const;
	GeListNode*			        function(const GeListNode *self ) GetUp;// const;
	GeListNode*			        function(const GeListNode *self ) GetDown;// const;
	GeListNode*			        function(const GeListNode *self ) GetDownLast;// const;
	void						function(GeListNode *self, GeListNode *bl) InsertBefore;
	void						function(GeListNode *self, GeListNode *bl) InsertAfter;
	void						function(GeListNode *self, GeListNode *bl) InsertUnder;
	void						function(GeListNode *self, GeListNode *bl) InsertUnderLast;
	void						function(GeListNode *self ) Remove;
	GeListHead*			        function(GeListNode *self ) GetListHead;
	BaseDocument*		        function(const GeListNode *self ) GetDocument;// const;

	GeListNode*			        function(const GeListHead *self ) GetFirst;// const;
	GeListNode*			        function(const GeListHead *self ) GetLast;// const;
	void						function(GeListHead *self ) FlushAll;
	void						function(GeListHead *self, GeListNode *bn) InsertFirst;
	void						function(GeListHead *self, GeListNode *bn) InsertLast;
	void						function(GeListHead *self, GeListNode *parent) SetParent;
	GeListNode*			        function(const GeListHead *self ) GetParent;// const;

	BaseList2D*			        function(const BaseList2D *self ) GetMain;// const;
	/*ref*/ const String*           function(const BaseList2D *self ) GetName;// const; //ref problem
	void						function(BaseList2D *self, ref const String str) SetName;
	Bool						function(BaseList2D *self, ref const DescID id,ref GeData t_data1,ref GeData t_data2,ref Float mix,DESCFLAGS_GET flags) GetAnimatedParameter;
	Bool						function(BaseList2D *self, Float scale) Scale;

	// AtomArray
	AtomArray*					function()AtomArrayAlloc;
	void						function(ref AtomArray * obj)AtomArrayFree;
	Int32						function(const AtomArray *self,) GetCount;// const;
	C4DAtom *				    function(const AtomArray *self, Int32 idx) GetIndex;// const;
	Bool						function(AtomArray *self, C4DAtom *obj) Append;
	void						function(AtomArray *self,) Flush;
	Bool						function(const AtomArray *self, AtomArray *dest) AACopyTo;// const;

	Int32						function(const AtomArray *self,) AAGetUserID;// const;
	void						function(AtomArray *self, Int32 t_userid) AASetUserID;

	void*						function(const AtomArray *self,) AAGetUserData;// const;
	void						function(AtomArray *self, void *t_userdata) AASetUserData;

	C4DAtom*				    function(const AtomArray *self,) AAGetPreferred;// const;
	void						function(AtomArray *self, C4DAtom *t_preferred) AASetPreferred;

	BaseShader*			        function(const BaseList2D *self,) GetFirstShader;// const;
	void						function(BaseList2D *self, BaseShader *shader, BaseShader *pred) InsertShader;

	Bool						function(BaseList2D *self, CTrack *track,ref const DescID id,ref const GeData t_data1,ref const GeData t_data2,Float mix,DESCFLAGS_SET flags) SetAnimatedParameter;
	void                        function(AtomArray *self, Int32 type, Int32 instance, Bool generators) AAFilterObject;
	Bool						function(AtomArray *self, AtomArray *dest, Int32 type, Int32 instance, Bool generators) AACopyToFilter;// const;
	Bool						function(AtomArray *self, AtomArray *src) AAAppendArr;
	void						function(AtomArray *self,) AAFilterObjectChildren;
	Bool						function(AtomArray *self, C4DAtom *obj) AARemove;

	Bool                        function(C4DAtom *self,ref const DescID id,ref const GeData t_data,DESCFLAGS_ENABLE flags,const BaseContainer *itemdesc) GetEnabling;
	Int32						function(const AtomArray *self, Int32 type, Int32 instance) AAGetCountTI;// const;

	Bool						function(const GeListNode *self ) IsDocumentRelated;// const;
	Int32						function(const AtomArray *self, C4DAtom *obj) AAFind;// const;
	Bool                        function(const GeListNode *self, NBIT bit) GetNBit;// const;
	Bool                        function(GeListNode *self, NBIT bit, NBITCONTROL bitmode) ChangeNBit;
	Int32						function(GeListNode *self, BranchInfo *info, Int32 max, GETBRANCHINFO flags) GetBranchInfo;
	Int32						function(const C4DAtom *self ) GetClassification;// const;
	Bool						function(const BaseList2D *self, BaseList2D *dst) TransferMarker;// const;
	/*ref*/ const GeMarker*	        function(const BaseList2D *self ) GetMarker;// const; //ref problem
	void						function(BaseList2D *self,ref const GeMarker m) SetMarker;
	GeMarker*					function()GeMarkerAlloc;
	void						function(ref GeMarker * obj)GeMarkerFree;
	Bool						function(const GeMarker *self,ref const GeMarker m) IsEqual;// const;
	Bool						function(const GeMarker *self,) Content;// const;
	Int32						function(const C4DAtom *self ) GetRealType;// const;
	Int32						function(const GeMarker *self,ref const GeMarker m) Compare;// const;
	void						function(GeMarker *self,ref const GeMarker m) GeMarkerSet;
	Bool						function(GeMarker *self, HyperFile *hf) GeMarkerRead;
	Bool						function(const GeMarker *self, HyperFile *hf) GeMarkerWrite;// const;
	Bool						function(BaseList2D *self, BaseList2D *dst, Bool undolink) TransferGoal;
	void						function(const GeMarker *self,ref void* data,ref Int32 size) GeMarkerGetMemory;// const;
	Bool						function(BaseList2D *self, Int32 appid, const Char * mem, Int bytes) AddUniqueID;
	Bool						function(const BaseList2D *self, Int32 appid,ref const Char * mem,ref Int bytes) FindUniqueID;// const;
	Int32						function(const BaseList2D *self,) GetUniqueIDCount;// const;
	Bool						function(const BaseList2D *self, Int32 idx,ref Int32 id,ref const Char * mem,ref Int bytes) GetUniqueIDIndex;// const;
	Bool						function(C4DAtom *self,ref const DescID id,ref DescID res_id,ref C4DAtom *res_at) TranslateDescID;

	Bool						function(AtomArray *self, AtomArray *cmp) AACompareArr;
};

struct C4D_Coffee; //TODO

//=============================================================================
struct C4D_BaseList
{
nothrow:
@nogc:

	Int32						function(const C4DAtom *at)GetDiskType;
	void						function(BaseList2D *bl, UInt32 *l1, UInt32 *l2)GetMarker;
	void						function(BaseList2D *bl, Int32 mask)SetAllBits;
	Int32						function(const BaseList2D *bl)GetAllBits;
	void						function(C4DAtom *at)Free;
	Bool						function(C4DAtom *at, HyperFile *hf, Int32 id, Int32 level)Read;
	Bool						function(C4DAtom *at, HyperFile *hf)Write;
	Bool						function(C4DAtom *bn, HyperFile *hf, Bool readheader)ReadObject;
	Bool						function(C4DAtom *bn, HyperFile *hf)WriteObject;
	void						function(BaseList2D *bl, BaseContainer *ct)GetData;
	void						function(BaseList2D *bl, const BaseContainer *ct, Bool add)SetData;
	BaseContainer*	            function(BaseList2D *bl)GetDataInstance;

	GeListHead*			        function()AllocListHead;
	GeListNode*			        function(Int32 bits, Int32 *id_array, Int32 id_cnt)AllocListNode;

	NodeData*				    function(GeListNode *bn, Int32 index)GetNodeData;
	Int32						function(GeListNode *bn, Int32 index)GetNodeID;
	NODEPLUGIN*			        function(GeListNode *node, Int32 index)RetrieveTable;
	NODEPLUGIN*			        function(NodeData *node, Int32 index)RetrieveTableX;

	GeListNode*			        function(GeListNode *bn)GetCustomData;
	void						function(GeListNode *bn, GeListNode *custom)SetCustomData;
	String					    function(BaseList2D *bl)GetBubbleHelp;

	void						function(BaseList2D *self,) ClearKeyframeSelection;
	Bool						function(BaseList2D *self, ref const DescID id) FindKeyframeSelection;
	Bool						function(BaseList2D *self, ref const DescID id, Bool selection) SetKeyframeSelection;
	Bool						function(BaseList2D *self,) KeyframeSelectionContent;

	// layer
	LayerObject*                function(BaseList2D *self, BaseDocument *doc) GetLayerObject;
	Bool                        function(BaseList2D *self, LayerObject *layer) SetLayerObject;
	const LayerData*            function(BaseList2D *self, BaseDocument *doc, Bool rawdata) GetLayerData;// const;
	Bool                        function(BaseList2D *self, BaseDocument *doc, ref const LayerData data) SetLayerDataEx;

	// animation system
	GeListHead*                 function(BaseList2D *self,) GetCTrackRoot;
	CTrack*	                    function(BaseList2D *self ) GetFirstCTrack;
	CTrack*	                    function(BaseList2D *self, ref const DescID id) FindCTrack;

	/*ref*/ const String *              function(BaseList2D *self ) GetTypeName; //ref problem

	void                        function(BaseList2D *self, CTrack *track) InsertTrackSorted;
	BaseList2D*			        function(Int32 type)Alloc;

	// nla system
	GeListHead*                 function(BaseList2D *self,) GetNLARoot;
	BaseList2D*                 function(BaseList2D *self, BaseObject **layer) AnimationLayerRemap;

	Bool                        function(BaseList2D *self, BaseList2D *bl, NOTIFY_EVENT eventid, NOTIFY_EVENT_FLAG flags, const BaseContainer *data) AddEventNotification;
	Bool                        function(BaseList2D *self, BaseDocument *doc, BaseList2D *bl, NOTIFY_EVENT eventid) RemoveEventNotification;
	Bool                        function(BaseList2D *self, BaseDocument *doc, BaseList2D *bl, NOTIFY_EVENT eventid) FindEventNotification;

	Bool                        function(BaseList2D *self, ref const DescID id, DESCIDSTATE descidstate) SetDescIDState;
	DESCIDSTATE                 function(BaseList2D *self, ref const DescID id, Bool tolerant) GetDescIDState;// const;

	Bool                        function(BaseList2D *self, BaseDocument *doc, ref const LayerData data) SetLayerData;
};

//=============================================================================
struct C4D_Tag
{
nothrow:
@nogc:

	BaseTag*				    function(Int32 type, Int32 count)Alloc;
	Int32						function(VariableTag *bt)GetDataCount;
	Int32						function(VariableTag *bt)GetDataSize;
	void *						function(VariableTag *bt)GetDataAddressW;
	BaseSelect*			        function(SelectionTag *tag)GetBaseSelect;
	Bool						function(StickTextureTag *stt, BaseObject *op, Bool always)Record;

	// UVWs
	void						function(UVWTag *tag, Int32 i, UVWStruct *s)UvGet;
	void						function(UVWTag *tag, Int32 i, UVWStruct *s)UvSet;
	void						function(UVWTag *tag, Int32 dst, UVWTag *srctag, Int32 src)UvCpy;

	BaseTag*				    function(BaseTag *tag)GetOrigin;
	const(void) *			    function(VariableTag *bt)GetDataAddressR;
	void						function(const(void) *handle, Int32 i, UVWStruct *s)UvGet2;
	void						function(void *handle, Int32 i, ref const UVWStruct  s)UvSet2;
	void						function(const(void) *srchandle, Int32 src, void *dsthandle, Int32 dst)UvCpy2;

	void						function(const(void) *handle, Int32 i, NormalStruct *s)NrmGet;
	void						function(void *handle, Int32 i, ref const NormalStruct  s)NrmSet;
	void						function(const(void) *srchandle, Int32 src, void *dsthandle, Int32 dst)NrmCpy;
};

//=============================================================================
struct C4D_Object
{
nothrow:
@nogc:

	BaseObject*			               function(Int32 type)Alloc;
	SplineObject*		               function(Int32 pcnt, SPLINETYPE type)AllocSplineObject;
	Float						       function(BaseObject *op, Float parent)GetVisibility;

	void/*Vector*/			           function(const BaseObject *self,Vector *result) GetAbsPos;// const;
	void						       function(BaseObject *self, ref const Vector v) SetAbsPos;
	void/*Vector*/			           function(const BaseObject *self,Vector *result) GetAbsScale;// const;
	void						       function(BaseObject *self, ref const Vector v) SetAbsScale;
	void/*Vector*/			           function(const BaseObject *self,Vector *result) GetAbsRot;// const;
	void						       function(BaseObject *self, ref const Vector v) SetAbsRot;

	///ref const Matrix 		         function(const BaseObject *self,) GetMl;// const; //ref problem
	alias ref const Matrix			   function(const BaseObject *self,) GetMlFT;		GetMlFT	 GetMl;

	void						       function(BaseObject *self, ref const Matrix m) SetMl;
	void/*Matrix*/			           function(const BaseObject *self,Matrix *result) GetMg;// const;
	void						       function(BaseObject *self, ref const Matrix m) SetMg;
	void/*Matrix*/					   function(const BaseObject *self,Matrix *result) GetMln;// const;
	void/*Matrix*/					   function(const BaseObject *self,Matrix *result) GetMgn;// const;
	void/*Matrix*/					   function(const BaseObject *self,Matrix *result) GetUpMg;// const;

	void/*Vector*/			           function(const BaseObject *self,Vector *result) GetFrozenPos;// const;
	void						       function(BaseObject *self, ref const Vector v) SetFrozenPos;
	void/*Vector*/			           function(const BaseObject *self,Vector *result) GetFrozenScale;// const;
	void						       function(BaseObject *self, ref const Vector v) SetFrozenScale;
	void/*Vector*/			           function(const BaseObject *self,Vector *result) GetFrozenRot;// const;
	void						       function(BaseObject *self, ref const Vector v) SetFrozenRot;
	void/*Matrix*/					   function(const BaseObject *self,Matrix *result) GetFrozenMln;// const;
	void/*Matrix*/					   function(const BaseObject *self,Matrix *result) GetRelMln;// const;

	void/*Vector*/			           function(const BaseObject *self,Vector *result) GetRelPos;// const;
	void						       function(BaseObject *self, ref const Vector v) SetRelPos;
	void/*Vector*/			           function(const BaseObject *self,Vector *result) GetRelScale;// const;
	void						       function(BaseObject *self, ref const Vector v) SetRelScale;
	void/*Vector*/			           function(const BaseObject *self,Vector *result) GetRelRot;// const;
	void						       function(BaseObject *self, ref const Vector v) SetRelRot;
	void/*Matrix*/					   function(const BaseObject *self,Matrix *result) GetRelMl;// const;
	void						       function(BaseObject *self, ref const Matrix m) SetRelMl;

	Vector					           function(BaseObject *op)GetMp;
	Vector					           function(BaseObject *op)GetRad;
	Int32						       function(BaseObject *op, OBJECTSTATE mode)GetMode;
	void						       function(BaseObject *op, OBJECTSTATE mode, Int32 val)SetMode;
	BaseTag*				           function(BaseObject *op)GetFirstTag;
	BaseTag*				           function(BaseObject *op, Int32 type, Int32 nr)GetTag;
	void *						       function(BaseObject *op, Int32 type, Int32 nr)GetTagData;
	Int32						       function(const BaseObject *op, Int32 type)GetTagDataCount;
	void						       function(BaseObject *op, BaseTag *tp, BaseTag *pred)InsertTag;
	void						       function(BaseObject *op, Int32 type, Int32 nr)KillTag;
	Int32						       function(GeListNode *op)GetInfo;
	Bool						       function(BaseList2D *op)Edit;
	BaseObject*			               function(BaseObject *op, HierarchyHelp *hh)GetCache;
	BaseObject*			               function(BaseObject *op)GetDeformCache;
	LineObject*			               function(BaseObject *op)GetIsoparm;
	Bool						       function(BaseObject *op, DIRTYFLAGS flags)IsDirty;
	void						       function(C4DAtom *op, DIRTYFLAGS flags)SetDirty;
	Bool						       function(BaseObject *op, HierarchyHelp *hh)CheckCache;
	void						       function(BaseObject *op, LineObject *l)SetIsoparm;
	BaseObject*			               function(BaseDocument *doc, Int32 type, const BaseContainer *bc, Float lod, Bool isoparm, BaseThread *bt)GenPrimitive;
	BaseObject*			               function(BaseDocument *doc, Int32 type, const BaseContainer *bc, Float lod, BaseThread *bt)GenSplinePrimitive;
	void						       function(BaseObject *op)NewDependenceList;
	Bool						       function(BaseObject *op)CmpDependenceList;
	void						       function(BaseObject *op)TouchDependenceList;
	void						       function(BaseObject *op,HierarchyHelp *hh, BaseObject *pp)AddDependence;
	Bool						       function(BaseList2D *op, const Filename *fn, AssetData *gd)AddTextureEx;
	BaseObject*			               function(BaseObject *op, HierarchyHelp *hh, ref const Matrix  mloc, Bool keep_spline, Bool recurse, Matrix *mres, Bool *dirty)GetVirtualLineObject;
	void						       function(BaseObject *op)Touch;

	// point object
	BaseSelect*			               function(PointObject *op)PoGetPointS;
	BaseSelect*			               function(PointObject *op)PoGetPointH;
	Bool						       function(PointObject *op, Int32 pcnt)PoResizeObject;
	Float32*					       function(PointObject *op, BaseObject *modifier)PoCalcVertexMap;

	// line object
	Bool						       function(LineObject *op, Int32 pcnt, Int32 scnt)LoResizeObject;

	// polygon object
	BaseSelect*			               function(PolygonObject *op)PyGetPolygonS;
	BaseSelect*			               function(PolygonObject *op)PyGetPolygonH;
	Bool						       function(PolygonObject *op, Int32 pcnt, Int32 vcnt)PyResizeObject;

	// spline object
	Vector					           function(SplineObject *op, Float t, Int32 segment, const Vector *padr)SpGetSplinePoint;
	Vector					           function(SplineObject *op, Float t, Int32 segment, const Vector *padr)SpGetSplineTangent;

	SplineLengthData*                  function()SpLDAlloc;
	void						       function(ref SplineLengthData * sp)SpLDFree;

	Bool						       function(SplineLengthData *dat, SplineObject *op, Int32 segment, const Vector *padr)SpInitLength;
	Float						       function(SplineLengthData *dat, Float t)SpUniformToNatural;
	Float						       function(SplineLengthData *dat)SpGetLength;
	Float						       function(SplineLengthData *dat, Int32 a, Int32 b)SpGetSegmentLength;
	LineObject*			               function(SplineObject *op, BaseDocument *doc, Float lod, BaseThread *thread)SpGetLineObject;
	SplineObject*		               function(BaseObject *op)SpGetRealSpline;
	Bool						       function(SplineObject *op, Int32 pcnt, Int32 scnt)SpResizeObject;

	// particle object
	Int32						       function(BaseObject *op)PrGetCount;
	Float						       function(BaseObject *op)PrGetLifetime;
	Particle*				           function(BaseObject *op, ParticleTag *pt, Int32 i)PrGetParticleW;
	Bool						       function(BaseObject *op)PrIsMatrixAvailable;
	ParticleDetails*                   function(BaseDocument *doc, BaseObject *op)PrGetParticleDetails;

	// camera object
	Int32						       function(BaseObject *op)CoGetProjection;
	Float						       function(BaseObject *op)CoGetFocus;
	Float						       function(BaseObject *op)CoGetZoom;
	Vector					           function(BaseObject *op)CoGetOffset;
	Float						       function(BaseObject *op)CoGetAperture;
	Bool						       function(BaseObject *op, Int32 projection)CoSetProjection;
	Bool						       function(BaseObject *op, Float v)CoSetFocus;
	Bool						       function(BaseObject *op, Float v)CoSetZoom;
	Bool						       function(BaseObject *op, ref const Vector  offset)CoSetOffset;
	Bool						       function(BaseObject *op, Float v)CoSetAperture;

	// object safety
	ObjectSafety*		               function(BaseObject *op)OsAlloc;
	void						       function(ObjectSafety *os, Bool restore)OsFree;

	// triangulation
	Bool						       function(const Vector *padr, Int32 pcnt, CPolygon **vadr, Int32 *vcnt)Triangulate;
	PolygonObject*	                   function(LineObject *op, Float regular, BaseThread *bt)TriangulateLine;
	SplineObject*		               function(Vector *padr, Int32 pcnt, Float error, BaseThread *bt)FitCurve;

	// uv stuff
	UVWTag*					           function(BaseObject *op, ref const Matrix  opmg, TextureTag *tp, ref const Matrix  texopmg, BaseView *view)GenerateUVW;

	UInt32						       function(const C4DAtom *op, DIRTYFLAGS flags)GetDirty;

	Bool						       function(const Vector *padr, Int32 pcnt, const Int32 *list, Int32 lcnt, ref CPolygon * vadr, ref Int32  vcnt, BaseThread *thread)TriangulateStandard;
	Bool						       function(const Vector *pinp, Int32 pinp_cnt, const Int32 *list, Int32 lcnt, ref Vector * padr, ref Int32  pcnt, ref CPolygon * vadr, ref Int32  vcnt, Float regular_width, BaseThread *thread)TriangulateRegular;

	Bool						       function(SplineObject *op)SpSetDefaultCoeff;
	BaseObject*			               function(BaseContainer *cp, BaseThread *bt, Bool separate)GenerateText;

	BaseSelect*			               function(PolygonObject *op)PyGetEdgeS;
	BaseSelect*			               function(PolygonObject *op)PyGetEdgeH;
	void						       function(BaseObject *op, ObjectColorProperties *co)GetColorProperties;
	void						       function(BaseObject *op, ObjectColorProperties *co)SetColorProperties;

	Bool						       function(BaseObject *op, BaseObject *dest, Int32 visible, Int32 variable, Int32 hierarchical, AliasTrans *trans)CopyTagsTo;
	BaseObject*			               function(BaseObject *op,HierarchyHelp *hh, BaseObject *pp, HIERARCHYCLONEFLAGS flags, Bool *dirty, AliasTrans *trans)GetHierarchyClone;

	BaseObject*			               function(BaseObject *op)GetCacheParent;
	Bool						       function(BaseObject *op, Int32 flags)CheckDisplayFilter;

	BaseSelect*			               function(PolygonObject *op)PyGetPhongBreak;

	Int32						       function(BaseObject *op)GetUniqueIP;
	void						       function(BaseObject *op, Int32 ip)SetUniqueIP;

	void						       function(BaseObject *op, BaseObject *origin)SetOrigin;
	BaseObject*			               function(BaseObject *op, Bool safe)GetOrigin;
	BaseObject*			               function(BaseObject *curr,Int32 booletype, HierarchyHelp *hh)InternalCalcBooleOld;

	Vector32*				           function(PolygonObject *op)CreatePhongNormals;

	// triangulation
	PolyTriangulate*                   function() PolyTriangAlloc;
	void                               function(ref PolyTriangulate * pTriang) PolyTriangFree;
	Bool                               function(PolyTriangulate* pTriang, const Vector* pvPoints, const Int32 lPointCount, const Int32* plSegments, const Int32 lSegCnt,
										ref CPolygon*  pPolys, ref Int32  lPolyCount, Int32 lFlags, const Int32* plMap, BaseThread* pThread,
										const Int32 lConstraints, const Int32* plConstrainedEdges) PolyTriangTriang;
	Bool                               function(PolyTriangulate* pTriang, const Vector* pvPoints, const Int32 lPointCount, const Int32* plSegments, const Int32 lSegCnt,
										ref CPolygon*  pPolys, ref Int32  lPolyCount, Int32 lFlags, const Int32* plMap, BaseThread* pThread,
										const Int32 lConstraints, const Int32* plConstrainedEdges) PolyTriangTriangRelease;

	Bool						       function(PolygonObject *op, ref Int32  ngoncnt, ref Int32 * polymap)PyGetPolygonTranslationMap;
	Bool						       function(PolygonObject *op, const Int32 ngoncnt, const Int32 *polymap, ref Int32 ** ngons)PyGetNGonTranslationMap;
	Pgon*                              function(PolygonObject *op)PyGetNgon;
	Int32                              function(PolygonObject *op)PyGetNgonCount;
	Bool						       function(PolygonObject *op, Int32 pcnt, Int32 vcnt, Int32 ncnt)PyResizeObjectNgon;
	void						       function(PolygonObject *op, BaseSelect* sel)PyGetSelectedNgons;
	void						       function(PolygonObject *op, BaseSelect* sel)PyGetHiddenNgons;
	NgonBase*				           function(PolygonObject *op)PyGetNgonBase;
	Bool						       function(PolygonObject *op, BaseSelect* sel)PyValidateEdgeSelection;
	Bool						       function(PolygonObject *op, BaseSelect* sel, EDGESELECTIONTYPE type)PyGetEdgeSelection;

	BaseObject*			               function(BaseObject *op, Bool parent, Bool safe)GetTopOrigin;
	BaseObject*			               function(BaseObject *op, BaseObject **psds, DISPLAYEDITSTATE state)GetEditObject;
	Int32						       function(BaseObject *op, BaseDraw *bd)GetHighlightHandle;

	/// ref const Matrix *             function(BaseObject *op, BaseDocument *doc) GetModelingAxis; //ref problem
	alias ref const Matrix			   function(const BaseObject *op, BaseDocument *doc)  GetModelingAxisFT;		GetModelingAxisFT	 GetModelingAxis;
	void                               function(BaseObject *op, ref const Matrix  m)SetModelingAxis;
	Bool                               function(PolyTriangulate* pTriang)PolyTriangHasIdentical;
	Bool                               function(BaseDraw *bd, PolygonObject *op, Vector *padr, UChar *pset, Bool select_visibonly)CalculateVisiblePoints;
	Int32                              function(PolyTriangulate* pTriang)PolyTriangGetType;

	void                               function(PolygonObject *op, ref UChar * edges)PyGetNgonEdgesCompact;
	UInt32						       function(PolygonObject *op, BaseDraw* bd)PyVBOInitUpdate;
	Bool						       function(PolygonObject *op, BaseDraw* bd, GlVertexBufferAccessFlags access, Bool latemap)PyVBOStartUpdate;
	void						       function(PolygonObject *op, Int32 i, ref const Vector32  v, const GlVertexBufferAttributeInfo* pInfo)PyVBOUpdateVector;
	void						       function(PolygonObject *op, BaseDraw* bd)PyVBOEndUpdate;
	void						       function(PolygonObject *op)PyVBOFreeUpdate;

	Int32						       function(PolygonObject *op, BaseDraw *bd, Float x, Float y, ref const Matrix  mg, Float *z, MODELINGCOMMANDMODE mode, UChar *pPointSelect, Int32 lSelectCount)IntersectionTest;

	Bool						       function(PolygonObject *op)PyValidateEdgeSelectionA;

	static if(__FLOAT_32_BIT) {
	Bool                               function(PolyTriangulate* pTriang, const Vector64* pvPoints, const Int32 lPointCount, const Int32* plSegments, const Int32 lSegCnt,
											ref CPolygon*  pPolys, ref Int32  lPolyCount, Int32 lFlags, const Int32* plMap, BaseThread* pThread,
											const Int32 lConstraints, const Int32* plConstrainedEdges)PolyTriangTriangA;
	Bool                               function(PolyTriangulate* pTriang, const Vector64* pvPoints, const Int32 lPointCount, const Int32* plSegments, const Int32 lSegCnt,
											ref CPolygon*  pPolys, ref Int32  lPolyCount, Int32 lFlags, const Int32* plMap, BaseThread* pThread,
											const Int32 lConstraints, const Int32* plConstrainedEdges)PolyTriangTriangReleaseA;
	}

	void                               function(PolyTriangulate* pTriang, Matrix64* m)PolyTriangSetPolygonMatrix;
	UInt32                             function(PolyTriangulate* pTriang)PolyTriangGetState;
	const Particle*	                   function(BaseObject *op, ParticleTag *pt, Int32 i)PrGetParticleR;

	void								function(BaseList2D *op, IconData *dat)GetIcon;

	UInt32						       function(const C4DAtom *self, HDIRTYFLAGS mask) GetHDirty;// const;
	void						       function(C4DAtom *self, HDIRTYFLAGS mask) SetHDirty;

	const void*			               function(const BaseObject *op, Int32 type, Int32 nr)GetTagDataR;

	void						       function(BaseObject *op)RemoveFromCache;
	Bool						       function(BaseObject *op, BaseObject *find)SearchHierarchy;
	Bool						       function(PolygonObject *op, Int32 pcnt, Int32 vcnt, Int32 ncnt, Int32 vc_flags)PyResizeObjectNgonFlags;
	void						       function(BaseObject *src, BaseObject *dst)CopyMatrixTo;
	Int32						       function(const BaseObject* op, BaseDocument* doc, BaseDraw* bd, RenderData* rd, Int32 flags)CoStereoGetCameraCount;
	Bool						       function(const BaseObject* op, BaseDocument* doc, BaseDraw* bd, RenderData* rd, Int32 n, ref StereoCameraInfo  info, Int32 flags)CoStereoGetCameraInfo;

	void						       function(BaseObject *self, ROTATIONORDER order) SetRotationOrder;
	ROTATIONORDER		               function(const BaseObject *self,) GetRotationOrder;// const;
	const GlVertexBufferAttributeInfo* function(PolygonObject *op, UInt32 flags)PyVBOUpdateVectorGetAttribute;

	void						       function(PolygonObject *op, Int32 i, ref const Vector32  v, const GlVertexBufferAttributeInfo* pInfo)PyVBOUpdateFaceVector;
	void						       function(PolygonObject *op)PyVBOInvalidate;
	void						       function(PointObject *op, Int32 cnt, Vector* v)PoIncreaseBoundingBox;

	UInt64                             function(BaseObject *op)GetGUID;			// Added in R14.004
	Bool						       function(BaseList2D *op, const Filename *fn, Bool netRequestOnDemand, AssetData *gd)AddTexture;
};

//=============================================================================
struct C4D_Document
{
nothrow:
@nogc:

	// render data
	RenderData*			         function()RdAlloc;

	// document
	BaseDocument*		         function()Alloc;
	void						 function(BaseDocument *doc)FlushAll;
	BaseContainer		         function(BaseDocument *doc, DOCUMENTSETTINGS type)GetData;
	void						 function(BaseDocument *doc, DOCUMENTSETTINGS type, const BaseContainer *bc)SetData;
	BaseObject*			         function(BaseDocument *doc)GetFirstObject;
	BaseMaterial*		         function(BaseDocument *doc)GetFirstMaterial;
	RenderData*			         function(BaseDocument *doc)GetFirstRenderData;
	void						 function(BaseDocument *doc, RenderData *rd, RenderData *parent, RenderData *pred)InsertRenderData;
	void						 function(BaseDocument *doc, BaseMaterial *mat, BaseMaterial *pred, Bool checknames)InsertMaterial;
	void						 function(BaseDocument *doc, BaseObject *op, BaseObject *parent, BaseObject *pred, Bool checknames)InsertObject;
	RenderData*			         function(BaseDocument *doc)GetActiveRenderData;
	BaseObject*			         function(BaseDocument *doc)GetActiveObject;
	BaseMaterial*		         function(BaseDocument *doc)GetActiveMaterial;
	BaseTag*				     function(BaseDocument *doc, BaseObject *active)GetActiveTag;
	void						 function(BaseDocument *doc, RenderData *rd)SetActiveRenderData;
	BaseObject*			         function(BaseDocument *doc, Int32 type, Bool editor)GetHighest;
	BaseMaterial*		         function(BaseDocument *doc, const String *str, Bool inc)SearchMaterial;
	BaseObject*			         function(BaseDocument *doc, const String *str, Bool inc)SearchObject;
	Bool						 function(BaseDocument *doc)StartUndo;
	Bool						 function(BaseDocument *doc)EndUndo;
	Bool						 function(BaseDocument *doc, UNDOTYPE type, void *data)AddUndoEx;
	Bool						 function(BaseDocument *doc)DoRedo;
	void						 function(BaseDocument *doc, BaseList2D *op, ref const BaseTime  time, ANIMATEFLAGS flags)AnimateObject;
	BaseDraw*				     function(BaseDocument *doc)GetActiveBaseDraw;
	BaseDraw*				     function(BaseDocument *doc)GetRenderBaseDraw;
	BaseDraw*				     function(BaseDocument *doc, Int32 num)GetBaseDraw;
	Int32						 function(BaseDocument *doc)GetSplinePlane;

	// hierarchy help
	Float						 function(HierarchyHelp *hh)HhGetLOD;
	BUILDFLAGS			         function(HierarchyHelp *hh)HhGetBuildFlags;
	BaseThread*			         function(HierarchyHelp *hh)HhGetThread;
	BaseDocument*		         function(HierarchyHelp *hh)HhGetDocument;
	/*ref*/ const Matrix* 		     function(HierarchyHelp *hh)HhGetMg; //ref problem

	// hierarchy
	Bool						 function(void *main, BaseDocument *doc, Bool spheres, Float lod, Bool uselod, BUILDFLAGS flags, void *startdata, BaseThread *bt, HierarchyAlloc *ha, HierarchyFree *hf, HierarchyCopyTo *hc, HierarchyDo *hd)RunHierarchy;

	BaseSceneHook*               function(const BaseDocument *doc,Int32 id)FindSceneHook;

	void						 function(BaseDocument *self, BaseObject *op,Int32 mode) SetActiveObject;
	void						 function(BaseDocument *self, ref AtomArray selection,GETACTIVEOBJECTFLAGS flags) GetActiveObjects;// const;
	void						 function(BaseDocument *self, ref AtomArray selection) GetActiveTags;// const;

	void						 function(PriorityList *list, GeListNode *node, Int32 priority, EXECUTIONFLAGS flags)PrAdd;
	BaseObject*			         function(BaseDocument *doc)GetHelperAxis;
	BaseVideoPost*               function(RenderData *rd)RdGetFirstVideoPost;
	void						 function(RenderData *rd, BaseVideoPost *pvp, BaseVideoPost *pred)RdInsertVideoPost;
	void						 function(BaseDocument *self, ref AtomArray selection) GetActiveMaterials;// const;

	void						 function(BaseDocument *doc, Int32 flags)SetRewind;

	void						 function(BaseDocument *self, BaseTag *op,Int32 mode) SetActiveTag;
	void						 function(BaseDocument *self, BaseMaterial *mat,Int32 mode) SetActiveMaterial;

	BaseVideoPost*               function(Int32 type)VpAlloc;

	BaseList2D*                  function(BaseDocument *doc)GetUndoPtr;
	void                         function(BaseDocument *doc, BaseList2D *undo, BaseList2D *op, Bool recursive, Bool pos, Bool scale, Bool rot, Bool param, Bool pla)AutoKey;
	Bool						 function(BaseDocument *doc, Bool multiple)DoUndo;
	Bool						 function(BaseDocument *doc, Bool force)IsCacheBuilt;
	void						 function(BaseDocument *self, ref AtomArray selection,Bool children) GetActivePolygonObjects;// const;
	BaseTime				     function(BaseDocument *doc, BaseList2D *check_op, Bool min)GetUsedTime;
	void						 function(BaseDocument *doc)ForceCreateBaseDraw;

	BaseContainer*               function(BaseDocument *doc, Int32 type)GetDataInstance;
	void						 function(BaseDocument *doc, Bool forward, Bool stop)RunAnimation;
	void						 function(BaseDocument *doc, ref const BaseTime  time)SetDocumentTime;

	BaseDocument*		         function(BaseDocument *doc,ref const AtomArray  t_objects)IsolateObjects;

	void						 function(BaseDocument *self, ref AtomArray selection) GetSelection;// const;
	void						 function(BaseDocument *self, BaseList2D *bl,Int32 mode) SetSelection;

	// layers
	LayerObject*		         function()DlAlloc;
	GeListHead*                  function(BaseDocument *doc)GetLayerObjectRoot;
	Bool                         function(BaseDocument *doc, BaseChannel *bc, ref const Filename  fn, Filename *resfilename, Bool undo, GEMB_R *already_answered)HandleSelectedTextureFilename;
	Bool                         function(BaseDocument *doc, BaseObject *op, AtomArray *mat, Bool clearfirst)ReceiveMaterials;
	Bool                         function(BaseDocument *doc, BaseObject *op, ref const Filename  filename, Bool sdown, GEMB_R *already_answered)ReceiveNewTexture;

	void                         function(BaseDocument *doc, CCurve *seq, Int32 kidx)SetKeyDefault;

	void                         function(BaseDocument *doc)Record;
	BaseContainer		         function(BaseDocument *doc, const AtomArray *ar)GetAllTextures;
	Bool						 function(BaseDocument *doc, BaseList2D *op, ref const BaseTime  time, ref const DescID  id, BaseList2D *undo, Bool eval_attribmanager, Bool autokeying, Bool allow_linking)RecordKey;

	Bool						 function()CloseAllDocuments;
	BaseObject*			         function(BaseDocument *doc, const AtomArray *help, Bool *multi)GetRealActiveObject;
	Bool						 function(BaseDocument *doc, BaseDraw* bd)AddUndoBD;

	Bool						 function(BaseDocument *doc, BaseSound *snd, ref const BaseTime  from, ref const BaseTime  to)CollectSounds;
	void                         function(BaseDocument *doc)RecordZero;

	MultipassObject*             function(RenderData *rd)RdGetFirstMultipass;
	void						 function(RenderData *rd, MultipassObject *pvp, MultipassObject *pred)RdInsertMultipass;
	MultiPassChannel *multipasschannels;
	void						 function(BaseDocument *doc, RenderData *rd)InsertRenderDataLast;

	void                         function(BaseDocument *doc)RecordNoEvent;
	Int32						 function(BaseDocument *doc)GetDrawTime;
	Bool						 function()StopExternalRenderer;
	Int32						 function(BaseDocument *doc)GetBaseDrawCount;
	Bool						 function(BaseDocument *self, BaseThread *bt, Bool animation, Bool expressions, Bool caches, BUILDFLAGS flags) ExecutePasses;

	const PickSessionDataStruct *function(BaseDocument *self,) GetPickSession;// const;
	void						 function(BaseDocument *self, PickSessionDataStruct *psd) StartPickSession;
	void						 function(BaseDocument *self, Bool cancel) StopPickSession;
	Bool						 function(BaseVideoPost* vp, BaseBitmap* dest, const BaseBitmap** source, Int32 cnt, ref const BaseContainer  settings, COLORSPACETRANSFORMATION transform)VpStereoMergeImages;
	Int32						 function(BaseVideoPost* vp, BaseDocument* doc, BaseDraw *bd)VpStereoGetCameraCountEditor;
	Int32						 function(BaseVideoPost* vp, BaseDocument* doc, RenderData* rd)VpStereoGetCameraCountRenderer;
	Bool						 function(BaseVideoPost* vp, BaseDocument* doc, BaseDraw *bd, RenderData* rd, Int32 index, ref StereoCameraInfo  info)VpStereoGetCameraInfo;
	Bool						 function(BaseVideoPost* vp, Int32 id)VpRenderEngineCheck;
	void						 function(BaseDocument *self, ref AtomArray selection, Bool children, Int32 type, Int32 instanceof) GetActiveObjectsFilter;// const;
	Bool						 function(BaseDocument *self, CKey* pKey,ref Bool bOverdub) GetDefaultKey;// const;
	void						 function(BaseDocument *self, CKey* pKey,Bool bOverdub) SetDefaultKey;
	BaseList2D*                  function(BaseDocument *doc, BaseList2D *bl, UNDOTYPE type)FindUndoPtr;
	void						 function(BaseDocument *doc, Int32 type, Int32 format, ref const Filename  fn, BaseList2D *bl, Bool hooks_only)SendInfo;
	void						 function(BaseDocument *self, BaseObject *op, Int32 mode) SetHighlightedObject;
	void						 function(BaseDocument *self, ref AtomArray selection, Int32 mode) SetHighlightedObjects;
	void						 function(BaseDocument *self, ref AtomArray selection) GetHighlightedObjects;// const;

	Bool						 function(BaseDocument *self,) IsAxisEnabled;
	Bool						 function(BaseDocument *doc, UNDOTYPE type, void *data, Bool allowFromThread)AddUndo;
	void						 function(BaseDocument *doc)FlushUndoBuffer;
	BaseBitmap*			         function(BaseDocument *self,) GetDocPreviewBitmap;
};

//=============================================================================
struct C4D_Thread
{
nothrow:
@nogc:

	BaseThread*					function(ThreadMain *tm, ThreadTest *tt, void *data, ThreadName *tn)Alloc;
	void						function(BaseThread *bt)Free;
	Bool						function(BaseThread *bt, THREADMODE mode, THREADPRIORITY priority, void *reserved)Start;
	void						function(BaseThread *bt, Bool wait)End;
	void						function(BaseThread *bt, Bool checkevents)Wait;
	Bool						function(BaseThread *bt)TestBreak;
	Bool						function(BaseThread *bt)TestBaseBreak;
	Bool						function(BaseThread *bt)IsRunning;
	THREADTYPE					function(BaseThread *bt)Identify;
	void						function()ThreadLock;
	void						function()ThreadUnlock;
	Int32						function()GetCPUCount;
	UInt32						function()GetCurrentThreadId;
	BaseThread*					function()GetCurrentThread;

	MPBaseThread*				function(BaseThread *parent, Int32 count, ThreadMain *tm, ThreadTest *tt, void **data, ThreadName *tn)MPAlloc;
	void						function(MPBaseThread *mp)MPFree;
	BaseThread*					function(MPBaseThread *mp, Int32 i)MPGetThread;
	void *						function(MPBaseThread *mp)MPWaitForNextFree;
	void						function(MPBaseThread *mp)MPWait;
	void						function(MPBaseThread *mp)MPEnd;

	Semaphore*					function()SMAlloc;
	void						function(ref Semaphore * sm)SMFree;
	Bool						function(Semaphore *sm)SMLock;
	Bool						function(Semaphore *sm, BaseThread *bt)SMLockAndWait;
	void						function(Semaphore *sm)SMUnlock;

	BaseThread					*NoThread;

	void						function(GeSpinlock *self,) Lock;
	void						function(GeSpinlock *self,) Unlock;
	Bool						function(GeSpinlock *self,) AttemptLock;

	void						function(GeRWSpinlock *self,) ReadLock;
	void						function(GeRWSpinlock *self,) ReadUnlock;
	void						function(GeRWSpinlock *self,) WriteLock;
	void						function(GeRWSpinlock *self,) WriteUnlock;
	Bool						function(GeRWSpinlock *self,) AttemptWriteLock;

	GeSignal*					function()SIGAlloc;
	void						function(ref GeSignal * sm)SIGFree;

	Bool						function(GeSignal *self, SIGNALMODE mode) SIGInit;
	void						function(GeSignal *self ) SIGSet;
	void						function(GeSignal *self ) SIGClear;
	Bool						function(GeSignal *self, Int32 timeout) SIGWait;
	Bool						function(Semaphore *sm, Int32 line, const(char) * file)SMLockDebug;
	Bool						function(Semaphore *sm, BaseThread *bt, Int32 line, const(char) * file)SMLockAndWaitDebug;

	void*						SystemMTable;
	void*						ThreadConnectionMTable;
	void*						JobQueueMTable;
	void*						WeakPtrTargetMTable;
	void*						cpuFlags;
	void*						StringMTable;
	void*						CStringMTable;
	void*						StringConversionMTable;
};

//=============================================================================
struct C4D_Material
{
nothrow:
@nogc:

	BaseMaterial*		        function(Int32 type)Alloc;
	void						function(BaseMaterial *mat, Int32 preview, Bool rttm)Update;
	BaseChannel*		        function(BaseMaterial *bm, Int32 id)GetChannel;
	Bool						function(Material *mat, Int32 channel)GetChannelState;
	void						function(Material *mat, Int32 channel, Bool state)SetChannelState;
	Bool						function(BaseMaterial *m1, BaseMaterial *m2)Compare;
	BaseBitmap*			        function(BaseMaterial *bm, Int32 flags)GetPreview;

	void						function(BaseMaterial *self, VolumeData *sd) Displace;
	void						function(BaseMaterial *self, VolumeData *sd) ChangeNormal;
	void						function(BaseMaterial *self, VolumeData *sd) CalcSurface;
	void						function(BaseMaterial *self, VolumeData *sd) CalcTransparency;
	void						function(BaseMaterial *self, VolumeData *sd) CalcAlpha;
	void						function(BaseMaterial *self, VolumeData *sd) CalcVolumetric;
	void						function(BaseMaterial *self, VolumeData *sd, INITCALCULATION type) InitCalculation;
	VOLUMEINFO			        function(BaseMaterial *self ) GetRenderInfo;

	Vector						function(BaseMaterial *mat, Int32 channel)GetAverageColor;
	GL_MESSAGE			        function(BaseMaterial *self, Int32 type, void *data) GlMessage;
	Bool						function(BaseMaterial *self,) HasEditorTransparency;
	RayIllumination*            function(BaseMaterial *self ) GetRayIllumination;
	INITRENDERRESULT            function(BaseMaterial *self, ref const InitRenderStruct irs) InitTextures;
	void						function(BaseMaterial *self ) UnlockTextures;
};

//=============================================================================
struct C4D_Texture
{
nothrow:
@nogc:

	Vector					    function(TextureTag *tag)GetPos;
	Vector					    function(TextureTag *tag)GetScale;
	Vector					    function(TextureTag *tag)GetRot;
	Matrix					    function(TextureTag *tag)GetMl;
	void						function(TextureTag *tag, ref const Vector  v)SetPos;
	void						function(TextureTag *tag, ref const Vector  v)SetScale;
	void						function(TextureTag *tag, ref const Vector  v)SetRot;
	void						function(TextureTag *tag, ref const Matrix  m)SetMl;

	void						function(TextureTag *tag, BaseMaterial *mat)SetMaterial;
	BaseMaterial*		        function(TextureTag *tag, Bool ignoredoc)GetMaterial;
};

//pragma(msg,C4D_Texture.sizeof/8);

//=============================================================================
struct C4D_BaseSelect
{
nothrow:
@nogc:

	BaseSelect*			        function()Alloc;
	void						function(BaseSelect *bs)Free;
	Int32						function(const BaseSelect *bs)GetCount;
	Int32						function(const BaseSelect *bs)GetSegments;
	Bool						function(BaseSelect *bs, Int32 num)Select;
	Bool						function(BaseSelect *bs, Int32 min, Int32 max)SelectAll;
	Bool						function(BaseSelect *bs, Int32 num)Deselect;
	Bool						function(BaseSelect *bs)DeselectAll;
	Bool						function(BaseSelect *bs, Int32 num)Toggle;
	Bool						function(BaseSelect *bs, Int32 min, Int32 max)ToggleAll;
	Bool						function(const BaseSelect *bs, Int32 seg, Int32 *a, Int32 *b)GetRangeEx;
	Bool						function(const BaseSelect *bs, Int32 num)IsSelected;
	Bool						function(const BaseSelect *bs, BaseSelect *dest)CopyTo;
	BaseSelect*			        function(const BaseSelect *bs)GetClone;
	Bool						function(BaseSelect *bs, UChar *selection, Int32 count)FromArray;
	UChar*					    function(const BaseSelect *bs, Int32 count)ToArray;
	Bool						function(BaseSelect *bs, const BaseSelect *src)Merge;
	Bool						function(BaseSelect *bs, const BaseSelect *src)DeselectBS;
	Bool						function(BaseSelect *bs, const BaseSelect *src)Cross;
	Bool						function(const BaseSelect *bs, Int32 num, Int32 *segment)FindSegment;
	BaseSelectData*	            function(BaseSelect *bs)GetData;
	Bool						function(BaseSelect *bs, BaseSelectData *ndata, Int32 ncnt)CopyFrom;
	Int32						function(const BaseSelect *bs)GetDirty;
	Int32						function(const BaseSelect *bs)GetLastElement;
	Bool						function(const BaseSelect *bs, Int32 seg, Int32 maxElements, Int32 *a, Int32 *b)GetRange;
};

struct C4D_CAnimation; //TODO 
struct C4D_BaseSound; //TODO 

//=============================================================================
struct C4D_BaseDraw
{
nothrow:
@nogc:

	// basedraw
	Bool						function(BaseDraw *bd)HasCameraLink;
	BaseObject*			        function(BaseDraw *bd)GetEditorCamera;
	Vector					    function(BaseDraw *bd, ref const Vector  col)CheckColor;
	void						function(BaseDraw *bd, Int32 trans)SetTransparency;
	Int32						function(BaseDraw *bd)GetTransparency;
	Bool						function(BaseDraw *bd, ref const Vector  p, Int32 x, Int32 y)PointInRange;
	void						function(BaseDraw *bd, ref const Vector  col, Int32 flags)SetPen;
	Float						function(BaseDraw *bd, ref const Vector  p, ref const Vector  n)SimpleShade;
	void						function(BaseDraw *bd, ref const Vector  p)DrawPoint2D;
	void						function(BaseDraw *bd, ref const Vector  p1, ref const Vector  p2)DrawLine2D; // draw line with 2D clipping
	void						function(BaseDraw *bd, ref const Vector  p, DRAWHANDLE type)DrawHandle2D;
	void						function(BaseDraw *bd, Int32 mx, Int32 my, Float rad)DrawCircle2D;
	DRAWRESULT			        function(BaseDraw *bd, BaseDrawHelp *bh, BaseObject *op, DRAWOBJECT drawpolyflags, DRAWPASS drawpass, BaseObject* parent, ref const Vector  col)DrawPObject;

	// basedraw help
	BaseDocument*		        function(BaseDrawHelp *bb)BbGetDocument;
	BaseTag*				    function(BaseDrawHelp *bb)BbGetActiveTag;
	///ref const Matrix  		    function(BaseDrawHelp *bb)BbGetMg; //ref problem
	alias ref const Matrix		function(const BaseDrawHelp *bb) BbGetMgFT;		BbGetMgFT	 BbGetMg;

	void						function(BaseDrawHelp *bb, BaseContainer *bc)BbGetDisplay;
	void						function(BaseDrawHelp *bb, BaseContainer *bc)BbSetDisplay;
	void						function(BaseDrawHelp *bb, ref const Matrix  mg)BbSetMg;
	DRAWFLAGS				    function(const BaseDrawHelp *bb)BbGetViewSchedulerFlags;
	BaseDrawHelp *              function(BaseDraw *bd, BaseDocument *doc)BbAlloc;
	void                        function(ref BaseDrawHelp * p)BbFree;

	BaseObject*			        function(BaseDraw *bd, const BaseDocument *doc)GetSceneCamera;
	Vector					    function(BaseDraw *bd, BaseObject *op, BaseDrawHelp *bh, Bool lines)GetObjectColor;
	void                        function(BaseDraw *bd, Int32 offset)LineZOffset;
	void                        function(BaseDraw *bd)SetMatrix_Projection;
	void                        function(BaseDraw *bd)SetMatrix_Screen;
	void                        function(BaseDraw *bd)SetMatrix_Camera;
	void                        function(BaseDraw *bd, BaseObject *op,ref const Matrix  mg)SetMatrix_Matrix;
	void                        function(BaseDraw *bd, ref const Vector  p1, ref const Vector  p2,Int32 flags)DrawLine;
	void                        function(BaseDraw *bd)LineStripBegin;
	void                        function(BaseDraw *bd, ref const Vector  vp,ref const Vector  vc,Int32 flags)LineStrip;
	void                        function(BaseDraw *bd)LineStripEnd;
	void                        function(BaseDraw *bd, ref const Vector  vp,DRAWHANDLE type,Int32 flags)DrawHandle;
	void						function(BaseDraw *bd, const BaseBitmap *bmp, Vector *padr4, Vector *cadr, Vector *vnadr, Vector *uvadr, Int32 pntcnt, DRAW_ALPHA alphamode, DRAW_TEXTUREFLAGS flags)DrawTexture;
	void						function(BaseDraw *bd, Int32 mode)SetLightList;

	void						function(BaseDraw *bd, BaseDocument *doc)InitUndo;
	void						function(BaseDraw *bd, BaseDocument *doc)DoUndo;
	void						function(BaseDraw *bd, Int32 id,ref const GeData  data)SetDrawParam;
	GeData					    function(BaseDraw *bd, Int32 id)GetDrawParam;

	void						function(BaseDraw *bd, Vector *vp,Vector *vf,Vector *vn,Int32 anz,Int32 flags)DrawPoly;
	DISPLAYFILTER		        function(BaseDraw *bd)GetDisplayFilter;
	DISPLAYEDITSTATE            function(BaseDraw *bd)GetEditState;
	Bool						function(BaseDraw *bd, BaseDocument *doc)IsViewOpen;

	void						function(BaseDraw *bd, ref const Matrix  m)DrawCircle;
	void						function(BaseDraw *bd, ref const Matrix  m, Float size, ref const Vector  col, Bool wire)DrawBox;
	void						function(BaseDraw *bd, Vector *p, Vector *f, Bool quad)DrawPolygon;
	void						function(BaseDraw *bd, ref const Vector  off, ref const Vector  size, ref const Vector  col, Int32 flags)DrawSphere;
	Bool						function(BaseDraw *bd)TestBreak;
	void						function(BaseDraw *bd)DrawArrayEnd;
	///ref OITInfo * 				function(BaseDraw *bd)GetOITInfo; //ref problem
	alias ref OITInfo			function(BaseDraw *bd) GetOITInfoFT;		GetOITInfoFT	 GetOITInfo;

	Int32						function(const BaseDraw *bd)GetGlLightCount;
	const GlLight*	            function(const BaseDraw *bd, Int32 lIndex)GetGlLight;

	Bool						function(BaseDraw *bd, ref Int32  lAttributeCount, ref const GlVertexBufferAttributeInfo** ppAttibuteInfo, ref Int32  lVectorInfoCount, ref const GlVertexBufferVectorInfo**  ppVectorInfo)GetFullscreenPolygonVectors;
	Bool						function(BaseDraw *bd, Int32 lVectorInfoCount, const GlVertexBufferVectorInfo** ppVectorInfo)DrawFullscreenPolygon;
	Bool						function(BaseDraw *bd, BaseObject *op,BaseDrawHelp *bh, Int32 flags)AddToPostPass;
	Bool						function(const BaseDraw* bd, ref BaseContainer  bc)GetDrawStatistics;

	void                        function(BaseDraw *bd, BaseObject *op,ref const Matrix  mg, Int32 zoffset)SetMatrix_MatrixO;
	void                        function(BaseDraw *bd, Int32 zoffset)SetMatrix_ScreenO;
	void                        function(BaseDraw *bd, Int32 zoffset)SetMatrix_CameraO;

	EditorWindow*		        function(BaseDraw *bd)GetEditorWindow;

	void						function(BaseDraw *bd, Int32 cnt, const Vector32 *vp, const Float32 *vc, Int32 colcnt, const Vector32 *vn)DrawPointArray;
	void						function(BaseDraw *bd, C4DGLuint bmp, Vector *padr4, Vector *cadr, Vector *vnadr, Vector *uvadr, Int32 pntcnt, DRAW_ALPHA alphamode)DrawTexture1;
	void						function(BaseDraw *bd, Int32 left, Int32 top, Int32 right, Int32 bottom, Int32 flags)InitClipbox;
	void						function(BaseDraw *bd, BaseContainer *camera, ref const Matrix  op_m, Float sv, Float pix_x, Float pix_y, Bool fitview)InitView;
	void						function(BaseDraw *bd, BaseDocument *doc, BaseObject *cam, Bool editorsv)InitializeView;
	void						function(BaseDraw *bd, BaseBitmap *bm, Bool tile, DRAW_ALPHA alphamode, DRAW_TEXTUREFLAGS flags)SetTexture;
	void						function(BaseDraw *bd, BaseObject *op, Bool animate)SetSceneCamera;
	void                        function(BaseDraw *bd, Int32 zoffset, const Matrix4d* m)SetMatrix_ScreenOM;

	Bool						function(BaseDraw *bd)InitDrawXORLine;
	void						function(BaseDraw *bd)FreeDrawXORLine;
	void						function(BaseDraw *bd, const Float32* p, Int32 cnt)DrawXORPolyLine;
	void						function(BaseDraw *bd)BeginDrawXORPolyLine;
	void						function(BaseDraw *bd, Bool blit)EndDrawXORPolyLine;
	BaseDraw*				    function()AllocBaseDraw;
	void						function(ref BaseDraw*  bv)FreeBaseDraw;

	Bool						function(BaseDraw* bd, Int32 flags)DrawScene;
	DISPLAYMODE			        function(const BaseDraw* bd)GetReductionMode;
	void						function(BaseDraw* bd, Bool bConsoleOutput, const(char) * pszFormat, ...)GlDebugString;
	void						function(BaseDraw* bd, Float pointsize)SetPointSize;
	Vector					    function(BaseDraw* bd, ref const Vector  c)ConvertColor;
	Vector					    function(BaseDraw* bd, ref const Vector  c)ConvertColorReverse;
	void						function(BaseDraw* bd, Bool enable)SetDepth;

	void						function(BaseDraw* bd, ref const Vector  pos, Float radius, Float angle_start, Float angle_end, Int32 subdiv, Int32 flags)DrawArc;
	DRAWPASS				    function(const BaseDraw* bd)GetDrawPass;
	void						function(BaseDraw* bd, Float o)SetClipPlaneOffset;
	Bool						function(const BaseDrawHelp *bb)BbIsActive;
	Bool						function(const BaseDrawHelp *bb)BbIsHighlight;
	Bool						function(const BaseDraw* bd, ref const BaseDrawHelp  bh, Bool lineObject, ref Vector  col)GetHighlightPassColor;
	GlFrameBuffer*	            function(BaseDraw* bd, ref const Vector32  vMin, ref const Vector32  vMax)GetHighlightFramebuffer;
	void						function(BaseDraw* bd, ref Float  step, ref Float  fade)GetGridStep;
	void						function(BaseDraw *bd, BaseDrawMessageHook fn)AddMessageHook;
};

//=============================================================================
struct C4D_BaseView
{
nothrow:
@nogc:

	void						function(BaseView *bv, Int32 *cl, Int32 *ct, Int32 *cr, Int32 *cb)GetFrame;
	void						function(BaseView *bv, Int32 *from, Int32 *to, Int32 *horizontal)GetSafeFrameEx;
	void						function(const BaseView *bv, Vector *offset, Vector *scale, Vector *scale_z)GetParameter;
	Matrix					    function(BaseView *bv)GetMg;
	Matrix					    function(BaseView *bv)GetMi;
	Int32						function(BaseView *bv)GetProjection;
	Bool						function(BaseView *bv, Float x, Float y)TestPoint;
	Bool						function(BaseView *bv, ref const Vector  p)TestPointZ;
	Bool						function(BaseView *bv, ref const Vector  mp, ref const Vector  rad, ref const Matrix  mg, Bool *clip2d, Bool *clipz)TestClipping3D;
	Bool						function(BaseView *bv, Vector *p1, Vector *p2)ClipLine2D;
	Bool						function(BaseView *bv, Vector *p1, Vector *p2)ClipLineZ;
	Vector					    function(BaseView *bv, ref const Vector  p)WS;
	Vector					    function(BaseView *bv, ref const Vector  p)SW;
	Vector					    function(BaseView *bv, Float x, Float y, ref const Vector  wp)SW_R;
	Vector					    function(BaseView *bv, ref const Vector  p)WC;
	Vector					    function(BaseView *bv, ref const Vector  p)CW;
	Vector					    function(BaseView *bv, ref const Vector  p)SC;
	Vector					    function(BaseView *bv, ref const Vector  p, Bool z_inverse)CS;
	Vector					    function(BaseView *bv, ref const Vector  v)WC_V;
	Vector					    function(BaseView *bv, ref const Vector  v)CW_V;
	Bool						function(BaseView *bv, ref const Vector  n, ref const Vector  p)BackfaceCulling;
	Bool						function(BaseView *bv)ZSensitiveNear;

	ViewportSelect*             function()VSAlloc;
	void                        function(ref ViewportSelect * p)VSFree;
	Bool						function(ViewportSelect *vs, Int32 w, Int32 h, BaseDraw* bd, BaseObject* op, Int32 mode, Bool onlyvisible, VIEWPORTSELECTFLAGS flags)VSInitObj;
	Bool						function(ViewportSelect *vs, Int32 w, Int32 h, BaseDraw* bd, AtomArray* ar, Int32 mode, Bool onlyvisible, VIEWPORTSELECTFLAGS flags)VSInitAr;
	ViewportPixel*	            function(ViewportSelect *vs, Int32 x, Int32 y)VSGetPixelInfoPoint;
	ViewportPixel*	            function(ViewportSelect *vs, Int32 x, Int32 y)VSGetPixelInfoPolygon;
	ViewportPixel*	            function(ViewportSelect *vs, Int32 x, Int32 y)VSGetPixelInfoEdge;
	void                        function(ViewportSelect *p, EditorWindow *bw, Int32 x, Int32 y)VSShowHotspot;
	void                        function(ViewportSelect *p, Int32 r)VSSetBrushRadius;
	void          	            function(ViewportSelect *vs, Int32 x, Int32 y, UChar mask)VSClearPixelInfo;
	Bool						function(ViewportSelect *vs, Float x, Float y, Float z, ref Vector  v)VSGetCameraCoordinates;
	Float						function(BaseView *bv)ZSensitiveNearClipping;
	Bool						function(ViewportSelect *vs, const Vector* p, Int32 ptcnt, Int32 i, BaseObject* op, Bool onlyvisible)VSDrawPolygon;
	Bool						function(ViewportSelect *vs, ref const Vector  p, Int32 i, BaseObject* op, Bool onlyvisible)VSDrawHandle;
	Int32						function(BaseDraw *bv, Int32 *cl, Int32 *ct, Int32 *cr, Int32 *cb)GetFrameScreen;
	/*ref*/ const Matrix4d * 	        function(BaseDraw *bv, Int32 n)GetViewMatrix; //ref problem
	ViewportPixel*	            function(ViewportSelect *vs, BaseObject* op, ref Int32  x, ref Int32  y, Int32 maxrad, Bool onlyselected, Int32* ignorelist, Int32 ignorecnt)VSGetNearestPoint;
	ViewportPixel*	            function(ViewportSelect *vs, BaseObject* op, ref Int32  x, ref Int32  y, Int32 maxrad, Bool onlyselected, Int32* ignorelist, Int32 ignorecnt)VSGetNearestPolygon;
	ViewportPixel*	            function(ViewportSelect *vs, BaseObject* op, ref Int32  x, ref Int32  y, Int32 maxrad, Bool onlyselected, Int32* ignorelist, Int32 ignorecnt)VSGetNearestEdge;
	void                        function(EditorWindow *bw, Int32 x, Int32 y, Int32 rad, Bool bRemove)VSShowHotspotS;
	Bool						function(BaseDraw* bd, BaseDocument* doc, Int32 x, Int32 y, Int32 rad, VIEWPORT_PICK_FLAGS flags, LassoSelection* ls, C4DObjectList* list, Matrix4d* m)VSPickObject;
	StereoCameraInfo*	        function(const BaseView* bd)GetStereoInfo;
	void						function(BaseDraw* bd, StereoCameraInfo* si)OverrideCamera;
	Bool						function(BaseView *bv)ZSensitiveFar;
	Float						function(BaseView *bv)ZSensitiveFarClipping;

	Float						function(BaseView *bv, Float z, Bool horizontal)PW_S;
	Float						function(BaseView *bv, Float z, Bool horizontal)WP_S;
	Float						function(BaseView *bv, ref const Vector  p, Bool horizontal)PW_W;
	Float						function(BaseView *bv, ref const Vector  p, Bool horizontal)WP_W;

	void						function(BaseView *bv, Int32 *cl, Int32 *ct, Int32 *cr, Int32 *cb)GetSafeFrame;

	Vector					    function(BaseView *bv, ref const Vector  p, ref const Vector  v, Float mouse_x, Float mouse_y, Float *offset, Int32 *err)ProjectPointOnLine;
	Vector					    function(BaseView *bv, ref const Vector  p, ref const Vector  v, Float mouse_x, Float mouse_y, Int32 *err)ProjectPointOnPlane;
	///ref const Matrix 		    function(const BaseView* bv)GetBaseMatrix; //ref problem
	alias ref const Matrix		function(const BaseView* bv)GetBaseMatrixFT;		GetBaseMatrixFT	 GetBaseMatrix;

	void						function(BaseView* bv, ref const Matrix  m)SetBaseMatrix;
	Float						function(const BaseView* bv)GetPlanarRotation;
	void						function(BaseView* bv, Float r)SetPlanarRotation;

	Bool						function(BaseDraw* bd, BaseDocument* doc, Int32 x, Int32 y, Int32 rad, ref Int32  xr, ref Int32  yr, ref Int32  wr, ref Int32  hr, ref ViewportPixel ** pixels, VIEWPORT_PICK_FLAGS flags, LassoSelection* ls, C4DObjectList* list, Matrix4d* m)VSPickObject1;
	Bool						function(BaseDraw* bd, BaseDocument* doc, Int32 x1, Int32 y1, Int32 x2, Int32 y2, ref Int32  xr, ref Int32  yr, ref Int32  wr, ref Int32  hr, ref ViewportPixel ** pixels, VIEWPORT_PICK_FLAGS flags, LassoSelection* ls, C4DObjectList* list, Matrix4d* m)VSPickObject2;
};

//=============================================================================
struct C4D_Pool
{
nothrow:
@nogc:

	MemoryPool*					function(Int block_size)Alloc;
	void						function(MemoryPool *pool)Free;
	void *						function(MemoryPool *pool, Int size, Bool clear)AllocElement;
	void						function(MemoryPool *pool, void *mem, Int size)FreeElement;
	void *						function(MemoryPool *pool, Int size, Bool clear)AllocElementS;
	void						function(MemoryPool *pool, void *mem)FreeElementS;
	void *						function(MemoryPool *pool, void * old, Int size, Bool clear)ReAllocElementS;
};

//=============================================================================
struct C4D_Link
{
nothrow:
@nogc:

	BaseLink*				    function()Alloc;
	void						function(BaseLink *link)Free;
	BaseList2D*			        function(const BaseLink *link, const BaseDocument *doc, Int32 instanceof)GetLink;
	void						function(BaseLink *link, C4DAtomGoal *list)SetLink;
	Bool						function(BaseLink *link, HyperFile *hf)Read;
	Bool						function(const BaseLink *link, HyperFile *hf)Write;
	BaseLink*				    function(const BaseLink *link, COPYFLAGS flags, AliasTrans *trn)GetClone;
	Bool						function(const BaseLink *src, BaseLink *dst, COPYFLAGS flags, AliasTrans *trn)CopyTo;
	AliasTrans*			        function()TrnAlloc;
	Bool						function(AliasTrans *trn, const BaseDocument *doc)TrnInit;
	void						function(AliasTrans *trn)TrnFree;
	void						function(AliasTrans *trn, Bool connect_oldgoals)TrnTranslate;
	BaseList2D*			        function(const BaseLink *link)ForceGetLink;
	Bool						function(const BaseLink *link)IsCacheLink;
	C4DAtomGoal*		        function(const BaseLink *link, const BaseDocument *doc, Int32 instanceof)GetLinkAtom;
	C4DAtomGoal*		        function(const BaseLink *link)ForceGetLinkAtom;
	void						function(BaseLink *link, C4DAtom *t_up_pointer)SetUpPointer;
};

//=============================================================================
struct C4D_Neighbor
{
nothrow:
@nogc:

	EnumerateEdges*	            function(Int32 pcnt, const CPolygon *vadr, Int32 vcnt, BaseSelect *bs)Alloc;
	void						function(EnumerateEdges *nb)Free;
	void						function(EnumerateEdges *nb, Int32 a, Int32 b,Int32 *first,Int32 *second)GetEdgePolys;
	void						function(EnumerateEdges *nb, Int32 pnt, Int32 **dadr, Int32 *dcnt)GetPointPolys;
	Int32						function(EnumerateEdges *nb)GetEdgeCount;
	PolyInfo*				    function(EnumerateEdges *nb, Int32 poly)GetPolyInfo;
	Bool    				    function(EnumerateEdges *nb, PolygonObject* op, ref Int32  ngoncnt, ref NgonNeighbor * ngons)GetNGons;
	void						function(EnumerateEdges *nb, const CPolygon *a_polyadr)ResetAddress;
};

//=============================================================================
struct C4D_Painter
{
nothrow:
@nogc:

	void *						function(Int32 command, BaseDocument *doc, PaintTexture *tex, const BaseContainer *bc)SendPainterCommand;
	Bool						function(const Vector *padr, Int32 PointCount, const CPolygon *polys, Int32 lPolyCount, UVWStruct *uvw, BaseSelect *polyselection,
															  BaseSelect* pointselection, BaseObject*op, Int32 mode, Int32 cmdid, ref const BaseContainer  settings)CallUVCommand;

	TempUVHandle*		        function(BaseDocument* doc, Int32 flags)GetActiveUVSet;
	void						function(TempUVHandle *handle)FreeActiveUVSet;

	Int32						function(TempUVHandle *handle)UVSetGetMode;
	const Vector*		        function(TempUVHandle *handle)UVSetGetPoint;
	Int32						function(TempUVHandle *handle)UVSetGetPointCount;
	const CPolygon*	            function(TempUVHandle *handle)UVSetGetPoly;
	Int32						function(TempUVHandle *handle)UVSetGetPolyCount;
	UVWStruct*			        function(TempUVHandle *handle)UVSetGetUVW;
	BaseSelect*			        function(TempUVHandle *handle)UVSetGetPolySel;
	BaseSelect*			        function(TempUVHandle *handle)UVSetGetPointSel;
	BaseObject*			        function(TempUVHandle *handle)UVSetGetBaseObject;

	Bool						function(TempUVHandle *handle, UVWStruct *uv)UVSetSetUVW;

	Bool						function(Int32 lCommand, AtomArray* pArray, BaseSelect **polyselection,ref BaseContainer  setttings, BaseThread* th)Private1;

	PaintTexture*		        function(ref const Filename  path, ref const BaseContainer  settings)CreateNewTexture;
	Bool						function(Int32 channel,ref BaseContainer  settings)GetTextureDefaults;

	Bool						function(TempUVHandle *handle)UVSetIsEditable;

	Int32						function(ref const Filename  texpath)IdentifyImage;
	Bool						function(BaseDocument *doc, ref const BaseContainer  settings, ref AtomArray  objects, ref AtomArray  material)BPSetupWizardWithParameters;

	Bool						function(BaseDocument *doc, ref AtomArray  materials, ref TextureSize * sizes)CalculateTextureSize;

	Int32						function(PaintBitmap *bmp)PB_GetBw;
	Int32						function(PaintBitmap *bmp)PB_GetBh;
	PaintLayer*			        function(PaintBitmap *tex)PB_GetLayerDownFirst;
	PaintLayer*			        function(PaintBitmap *tex)PB_GetLayerDownLast;
	PaintLayerBmp*	            function(PaintTexture *tex,PaintLayer *insertafter,PaintLayer *layerset,COLORMODE mode,Bool useundo, Bool activate)PT_AddLayerBmp;
	GeListHead*			        function()PT_GetPaintTextureHead;
	Bool						function(PaintLayerBmp *layer,BaseBitmap *bmp, Bool usealpha)PLB_ImportFromBaseBitmap;
	Bool						function(PaintLayerBmp *layer,BaseBitmap *bmp,BaseBitmap *channel)PLB_ImportFromBaseBitmapAlpha;
	Bool						function(PaintLayerBmp *layer,Int32 x,Int32 y,Int32 num,PIX *dst,COLORMODE dstmode,PIXELCNT flags)PLB_GetPixelCnt;
	PaintTexture*		        function(BaseDocument *doc,BaseChannel *bc)GetPaintTextureOfBaseChannel;

	LayerSet*				    function()LSL_Alloc;
	void						function(LayerSet *layerset)LSL_Free;
	Bool						function(const LayerSet *l)LSL_Content;
	Bool						function(const LayerSet *l,ref const String  name)LSL_IsLayerEnabled;
	Bool						function(const LayerSet *l,ref const String  name)LSL_FindLayerSet;
	String					    function(const LayerSet *l)LSL_GetName;
	LAYERSETMODE		        function(const LayerSet *l)LSL_GetMode;
	void						function(LayerSet *l,LAYERSETMODE t_mode)LSL_SetMode;
	void						function(LayerSet *l,ref const String  layer)LSL_RemoveLayer;
	void						function(LayerSet *l,ref const String  layer)LSL_AddLayer;
	void						function(LayerSet *l)LSL_FlushLayers;
	Bool						function(const LayerSet *l,ref const LayerSet  layerset)LSL_operator_cmp;
	void						function(const LayerSet *l,ref LayerSet  dst)LSL_CopyTo;
	Bool						function(const(void) *msgdata, ref const BaseContainer  d)GetAllStrings_AddTexture;

	PaintTexture*		        function(PaintBitmap *bmp)PB_GetPaintTexture;
	PaintBitmap*		        function(PaintBitmap *bmp)PB_GetParent;
	PaintLayer*			        function(PaintBitmap *bmp)PB_GetAlphaFirst;
	PaintLayer*			        function(PaintBitmap *bmp)PB_GetAlphaLast;
	PaintLayerBmp*	            function(PaintBitmap *bmp,Int32 bitdepth,PaintLayer *prev,Bool undo, Bool activate)PB_AddAlphaChannel;
	Bool						function(PaintBitmap *bmp)PB_AskApplyAlphaMask;
	void						function(PaintBitmap *bmp,Int32 x,Int32 y,Int32 num,PIX *bits,Int32 mode,Bool inverted, Int32 flags)PB_ApplyAlphaMask;
	PaintLayerMask*	            function(PaintBitmap *bmp,PaintBitmap **toplevel,Int32 *bitdepth)PB_FindSelectionMask;
	Int32						function(PaintBitmap *bmp)PB_GetColorMode;
	UInt32						function(PaintBitmap *bmp,DIRTYFLAGS flags)PB_GetDirty;
	void						function(PaintBitmap *bmp,Int32 xmin,Int32 ymin,Int32 xmax,Int32 ymax,UInt32 flags)PB_UpdateRefresh;
	void						function(PaintBitmap *bmp,UInt32 flags,Bool reallyall)PB_UpdateRefreshAll;
	Bool						function(PaintBitmap *bmpthis,BaseThread *thread,Int32 x1,Int32 y1,Int32 x2,Int32 y2,BaseBitmap *bmp,Int32 flags,UInt32 showbit)PB_ReCalc;
	Bool						function(Int32 num,const PIX *src,Int32 srcinc,COLORMODE srcmode,PIX *dst,Int32 dstinc,COLORMODE dstmode,Int32 dithery,Int32 ditherx)PB_ConvertBits;
	Bool						function(PaintLayerBmp *layer,Int32 x,Int32 y,Int32 num,const PIX *src,Int32 incsrc,COLORMODE srcmode,PIXELCNT flags)PLB_SetPixelCnt;
	void						function(PaintLayerBmp *layer,ref Int32  x1,ref Int32  y1,ref Int32  x2,ref Int32  y2, Bool hasselectionpixels)PLB_GetBoundingBox;
	PaintLayerFolder*           function(PaintTexture *tex,PaintLayer *insertafter,PaintLayer *insertunder,Bool useundo, Bool activate)PT_AddLayerFolder;
	void						function(PaintTexture *tex,PaintLayer *layer,Bool activatetexture,Bool show)PT_SetActiveLayer;
	PaintLayer*			        function(PaintTexture *tex)PT_GetActive;
	void						function(PaintTexture *tex,ref AtomArray  layers, Bool addfolders)PT_GetLinkLayers;
	Bool						function(PaintBitmap *bmp, PaintMaterial *preferred)PT_SetSelected_Texture;
	PaintTexture*		        function()PT_GetSelectedTexture;
	PaintTexture*		        function(PaintMaterial **ppmat)PT_GetSelectedTexturePP;
	void						function(PaintMaterial *,BaseDocument *doc,Bool on,Bool suppressevent,Bool domaterialundo)PM_EnableMaterial;
	PaintMaterial*	            function(BaseDocument *doc,BaseMaterial **mat)PM_GetActivePaintMaterial;
	PaintMaterial*	            function(PaintTexture *tex,Bool onlyeditable)PM_GetPaintMaterialFromTexture;
	PaintMaterial*	            function(BaseDocument *dok,BaseMaterial *material,Bool create)PM_GetPaintMaterial;
	Bool						function(BaseDocument *doc,BaseMaterial *material,Bool forcesave)PM_UnloadPaintMaterial;
	Bool						function(PaintTexture *tex,COLORMODE newcolormode,Bool doundo)PT_SetColorMode;

	void						function(LayerSet *l, Int32 mode)LSL_SetPreviewMode;
	Int32						function(const LayerSet *l)LSL_GetPreviewMode;
	LayerSetHelper *            function()LSH_Alloc;
	void						function(LayerSetHelper *lsh)LSH_Free;
	Bool						function(LayerSetHelper *lsh, ref const Filename  fn, const LayerSet *selection)LSH_Init;
	Bool						function(LayerSetHelper *lsh,ref const String  dialogtitle, LayerSet *layerset, LayerSet *layerset_a)LSH_EditLayerSet;

	Bool						function(BaseDocument *doc, ref const Filename  filename, Int32 *xres, Int32 *yres)CLL_CalculateResolution;
	Bool						function(BaseDocument *doc, ref Filename  fn, LayerSet *lsl)CLL_CalculateFilename;

	Bool						function(PaintLayer *bmp,Bool hierarchy, UInt32 bit)PL_GetShowBit;
	Bool						function(PaintLayer *bmp,Bool onoff, UInt32 bit)PL_SetShowBit;
	PaintTexture*		        function(ref String  result,ref Filename  resultdirectory,Int32 channelid,BaseMaterial *bmat)PT_CreateNewTextureDialog;
	void						function(Int32 channel, Bool multi, Bool enable)PN_ActivateChannel;
	const Filename              function(PaintTexture *tex)PT_GetFilename;

	Bool						function(LayerSetHelper *lsh, ref const LayerSet  selection, BaseBitmap *bmp, Bool preview)LSH_MergeLayerSet;
	Bool						function(BaseDocument *doc)PM_AskNeedToSave;
	Bool						function(BaseDocument *doc, ref Bool  cancel)PM_SaveDocument;

	BaseSelect*			        function(TempUVHandle *handle)UVSetGetPolyHid;
	Bool						function(TempUVHandle *handle, UVWStruct *uv, Bool ignoreHidden, Bool ignoreUnselected, Bool autoSelectAll)UVSetSetUVWFromTextureView;
};

struct C4D_GLSL; //TODO 

//=============================================================================
///Network >>>
enum IPV4_SIZE = 4;		//IPv4 32-Bit
enum IPV6_SIZE = 16;	//IPv6 128-Bit

union GeSockAddrIn
{
	UChar ipv4[IPV4_SIZE];
	UChar ipv6[IPV6_SIZE];
};

struct IpAddr
{
private:
	GeSockAddrIn	dummy1;
	PROTOCOL		dummy2;
};

struct IpAddrPort //? : IpAddr
{
private:
	IpAddr	 super0;
	alias	super0 this;

	Int      dummy3;
};

struct NetworkInterface;
struct ZeroConfBrowser;
struct ZeroConfService;


extern (C++, maxon) {  // namespace maxon
//=============================================================================
struct BaseArray(T)  //TODO
{
protected:
	T*	_ptr;
	Int _cnt;			// number of used array elements
	Int _capacity;		// number of allocated array elements

	//TODO: >>>
};

static assert( BaseArray!(Int32).sizeof == 24 );

} //extern (C++, N) 

//=============================================================================
struct C4D_Network
{
	// IpAddr
	Bool								function(IpAddr *self, const ref IpAddr adr) Compare;// const;
	Bool								function(IpAddr *self,) IsValid1;// const;
	String							    function(IpAddr *self, Int port) GetString;// const;
	int									function(IpAddr *self,) GetNativeProtocol;// const;
	Bool								function(IpAddr *self, HyperFile *hf) Write;// const;
	Bool								function(IpAddr *self, HyperFile *hf) Read;
	PROTOCOL						    function(IpAddr *self,) GetProtocol;// const;
	void								function(IpAddr *self,) Flush;
	Bool								function(IpAddr *self, UChar a, UChar b, UChar c, UChar d) SetIPv4;
	Bool								function(IpAddr *self, Int16 x1, Int16 x2, Int16 x3, Int16 x4, Int16 x5, Int16 x6, Int16 x7, Int16 x8) SetIPv6;
	Bool								function(IpAddr *self, ref IpAddr adr) CopyTo;// const;
	Bool								function(IpAddr *self, ref UChar a, ref UChar b, ref UChar c, ref UChar d) GetIPv4;// const;
	Bool								function(IpAddr *self, ref Int16 x1, ref Int16 x2, ref Int16 x3, ref Int16 x4, ref Int16 x5, ref Int16 x6, ref Int16 x7, ref Int16 x8) GetIPv6;// const;
	Bool								function(IpAddr *self,) IsPrivateAddress;// const;

	// IpAddrPort
	Bool								function(IpAddrPort *self, HyperFile *hf) WriteAP;// const;
	Bool								function(IpAddrPort *self, HyperFile *hf) ReadAP;
	Bool								function(IpAddrPort *self,) IsValid2;// const;
	String							    function(IpAddrPort *self, Bool getPort) GetStringAP;// const;
	void								function(IpAddrPort *self, Int t_port) SetPort;
	Int									function(IpAddrPort *self,) GetPort;// const;

	// NetworkInterface
	String							    function(NetworkInterface *self,) GetInterfaceName;// const;
	Int									function(NetworkInterface *self,) GetInterfaceIndex;// const;
	void								function(NetworkInterface *self, ref maxon.BaseArray!(UChar) macAddress) GetMacAddress;// const;
	String							    function(NetworkInterface *self,) GetDescription;// const;
	Int									function(NetworkInterface *self,) GetCountAddress;// const;
	Bool								function(NetworkInterface *self,) IsLoopback;// const;
	IpAddr							    function(NetworkInterface *self, Int i) GetIpAddress;// const;
	IpAddr							    function(NetworkInterface *self, Int i) GetBroadcastAddress;// const;
	IpAddr							    function(NetworkInterface *self, Int i) GetSubnetMask;// const;
	NetworkInterface*		            function(NetworkInterface *self,) NetworkInterfaceGetClone;// const;
	Bool								function(NetworkInterface *self, ref NetworkInterface networkInterface) NetworkInterfaceCopyTo;// const;
	Bool								function(NetworkInterface *self, ref const IpAddr ipAddr, ref const IpAddr broadcastAddress, ref const IpAddr subnetMask) Append;
	Bool								function(NetworkInterface *self, HyperFile* hf) NetworkInterfaceWrite;// const;
	Bool								function(NetworkInterface *self, HyperFile* hf) NetworkInterfaceRead;
	BaseContainer				        function(NetworkInterface *self,) GetCustomData;// const;
	void								function(NetworkInterface *self, ref const BaseContainer customData) SetCustomData;
	NetworkInterface*		            function()NetworkInterfaceAlloc;
	void								function(ref NetworkInterface*  p)NetworkInterfaceFree;

	// IpConnection
	Int64								function(IpConnection *self,) GetTransferedBytes;// const;
	/*ref*/ const IpAddrPort*		    function(IpConnection *self,) GetRemoteAddr;// const; //ref problem
	/*ref*/ const IpAddrPort*		    function(IpConnection *self,) GetHostAddr;// const; //ref problem

	IpConnection*				        function(ref const IpAddrPort  adr, BaseThread* thread, Int timeout, Bool useNagleAlgorithm, Int* error)IpOpenListener;
	IpConnection*				        function(ref const String  adr, BaseThread* thread, Int timeout, Bool useNagleAlgorithm, Int* error)IpOpenListenerString;
	IpConnection*				        function(ref const IpAddrPort  adr, BaseThread* thread, Int initialTimeout, Int timeout, Bool useNagleAlgorithm, Int* error)IpOpenOutgoing;
	IpConnection*				        function(ref const String  adr, BaseThread* thread, Int initialTimeout, Int timeout, Bool useNagleAlgorithm, Int* error)IpOpenOutgoingString;
	IpConnection*				        function(IpConnection* listener, BaseThread* connection, Int* error)IpWaitForIncoming;
	void								function(IpConnection* ipc)IpCloseConnection;
	void								function(IpConnection* ipc)IpKillConnection;

	Int									function(IpConnection* ipc)IpBytesInInputBuffer;
	Int									function(IpConnection* ipc, void * buf, Int size)IpReadBytes;
	Int									function(IpConnection* ipc, const(void) * buf, Int size)IpSendBytes;

	ZeroConfBrowser*		            function(ref const String  servicetype, ZeroConfBrowserCallback t_callback_found, ZeroConfBrowserResolvedCallback callback_txt, void *context, Bool thirdPartyInstance)StartZeroConfBrowser;
	void								function(ZeroConfBrowser* browser)StopZeroConfBrowser;
	ZeroConfService*		            function(String serviceName, ref const String  serviceType, Int lInterface, Int port, ref const String  domainName, Bool thirdPartyInstance)RegisterZeroConfService;
	void								function(ZeroConfService* service)DeregisterZeroConfService;
	Bool								function(ZeroConfService* service)RemoveTXTRecord;
	Bool								function(ZeroConfService* service, const String* keys, const String* values, Int cnt)SetTXTRecord;

	String							    function()GetHostname;
	Int									function(ref const String  interfaceName)GetInterfaceIndex2;
	NetworkInterface*		            function(PROTOCOL protocol)GetBestNetworkInterface;
	Bool								function(ref maxon.BaseArray!(NetworkInterface*) networkInterfaces) GetAllNetworkInterfaces;
	Bool								function(ref const String  address, ref IpAddr  a, Bool resolve, Bool forceResolve)GetIpAddress2;
	Bool								function(ref const String  address, ref IpAddrPort  a, Bool resolve, Bool forceResolve)GetIpAddress3;
	RESOLVERESULT						function(ref const String address, PROTOCOL protocol, ref maxon.BaseArray!(IpAddr) addrs, Bool firstMatch, Bool forceResolve) ResolveHostname;


	Bool								function(ref maxon.BaseArray!(UChar) macAddress)GetMacAddress2;
	Bool								function(ref const maxon.BaseArray!(UChar) macAddress, ref const IpAddr broadcast) WakeOnLan;
	Bool								function(ref Int  versionNumber, ref Int  revisionNumber, ref Bool  isRunning)GetBonjourVersion;
	Bool								function(String address, String *scheme, String *host, Int *port)SplitAddress;
	String							    function(ref const IpAddr  ipAddr)GetHostname2;

	void								function(IpAddr *self,) SDKAlloc;
	void								function(IpAddr *self, const ref IpAddr adr) SDKAlloc2;
	void								function(IpAddr *self,) SDKFree;
	Bool								function(IpAddr *self,) IsEmpty;// const;
	const GeSockAddrIn*                 function(IpAddr *self,) GetGeSockAddrIn;// const;
	void								function(IpAddrPort *self,) SDKAllocPort;
	void								function(IpAddrPort *self, ref const IpAddr adr, Int port) SDKAllocPort2;
	Bool								function(IpAddrPort *self, ref const IpAddrPort adr) CompareAP;// const;
};

//=============================================================================
struct OperatingSystem 
{
	int c4d_api_version;

	C4D_General				*Ge;
	C4D_Shader				*Sh; 
	C4D_HyperFile			*Hf; 
	C4D_BaseContainer		*Bc;
	C4D_String				*St; 
	C4D_Bitmap				*Bm; 
	C4D_MovieSaver			*Ms;
	C4D_BaseChannel			*Ba;
	C4D_Filename			*Fn;
	C4D_File				*Fl;
	C4D_BrowseFiles		    *Bf;
	C4D_Dialog			    *Cd;
	C4D_UserArea			*Cu;
	C4D_Parser			    *Pr;
	C4D_Resource			*Lr;
	C4D_BaseList			*Bl;
	C4D_Tag				    *Tg;
	C4D_Object			    *Bo;
	C4D_Document			*Bd; 
	C4D_Thread			    *Bt;
	C4D_Material			*Mt; 
	C4D_Texture			    *Tx; 
	C4D_BaseSelect		    *Bs;
	C4D_BaseSound			*Bu;
	C4D_BaseDraw			*Br;
	C4D_BaseView			*Bv;
	C4D_Neighbor			*Nb;
	C4D_Pool				*Pl;
	C4D_BitmapFilter		*Fi;
	C4D_Painter			    *Pa;
	C4D_Link				*Ln;
	C4D_GraphView			*Gv;
	C4D_GeData			    *Gd;
	C4D_Atom				*At;
	C4D_Coffee			    *Co;
	C4D_CAnimation		    *CA;
	C4D_CrashHandler		CrashHandler;
	C4D_CreateOpenGLContext	CreateOpenGLContext;
	C4D_DeleteOpenGLContext	DeleteOpenGLContext;
	C4D_GLSL				*GL;
	C4D_Network				*Ne;
	C4D_Uuid				*Gu;
};



__gshared static OperatingSystem *t_C4DOS = null;
alias t_C4DOS C4DOS; //hm



} //extern (C++)


//-----------------------------------------------------------------------------
int InitOS(void *p) {
	t_C4DOS = (cast(OperatingSystem*)p); 
	printf(" InitOS %i \n",C4DOS.c4d_api_version);
	return C4DOS.c4d_api_version;
}	 

//-----------------------------------------------------------------------------

//static assert(test_return_types_size!(C4D_General), wrong_return_types_size_list!(C4D_General));
//static assert(test_return_types_size!(C4D_Shader), wrong_return_types_size_list!(C4D_Shader));
//static assert(test_return_types_size!(C4D_HyperFile), wrong_return_types_size_list!(C4D_HyperFile));
//static assert(test_return_types_size!(C4D_BaseContainer) , wrong_return_types_size_list!(C4D_BaseContainer));
static assert(test_return_types_size!(C4D_Bitmap) , wrong_return_types_size_list!(C4D_Bitmap));
//static assert(test_return_types_size!(C4D_GeData) , wrong_return_types_size_list!(C4D_GeData));

/+
unittest {

	import std.traits;

	//pragma(msg,__traits(allMembers, C4D_MovieSaver));

	//C4D_MovieSaver tmp;
	//pragma(msg,__traits(getMember, tmp, "Alloc"));

	//mixin( " pragma(msg,__traits(allMembers, C4D_MovieSaver)); ");

	//pragma(msg,typeof(C4D_MovieSaver.Write));

	//return true if all return types are smalles as 8 bytes.
	bool test_return_types(alias T)(){
		foreach (id; __traits(allMembers, T) ) {
			mixin(" if( ReturnType!(typeof(T." ~ id ~ ")).sizeof > 8){ return false; } "); 
		}
		return true;
	}
	pragma(msg,test_return_types!C4D_MovieSaver );


	//return string with the name of function with return type bigger as 8 bytes 
	// or "" if all functions are OK.
	string test_return_types2(alias T)(){
		string str;
		foreach (int i, id; __traits(allMembers, T) ) {
			mixin(" if( ReturnType!(typeof(T." ~ id ~ ")).sizeof > 8){
				  str ~= typeof(T." ~ id ~ ").stringof ~ \"\\n\";
				  //return typeof(T." ~ id ~ ").stringof;
			} "); 
		}
		return str; //OK
	}
	pragma(msg,test_return_types2!C4D_Bitmap );


	string get_list(alias T)(){
		string str;
		foreach (id; __traits(allMembers, T) ) {
			//str ~= id ~ "\n";
			mixin( "str ~= typeof(T." ~ id ~ ").stringof ~ \"\\n\";" );
			//mixin( "str ~= ReturnType!(typeof(T." ~ id ~ ")).stringof ~ \"\\n\";" );
		}
		return str;
	}
	//? pragma(msg,get_list!C4D_MovieSaver );

	//? pragma(msg,get_list!C4D_GeData ); //DO NOT WORK !!

	/*mixin( "
		    foreach (t; __traits(allMembers, C4D_MovieSaver) ]) {
				typeof(C4D_MovieSaver.Write)
			}
		   
		   
		   ");*/

}
+/