
module c4d_general;

public import c4d;
public import c4d_os;
public import c4d_prepass;
public import c4d_string;

//c4d String
void GePrint(ref const String str) {
	C4DOS.Ge.Print(str);
}
void GePrint(in String str) {
	C4DOS.Ge.Print(str);
}

//utf8
void GePrint(in string str) { 
	const String tmp = String(str);
	C4DOS.Ge.Print(tmp);
}
//utf16
void GePrint(in wstring str) { 
	const String tmp = String(str);
	C4DOS.Ge.Print(tmp);
}
//utf32
void GePrint(in dstring str) { 
	const String tmp = String(str);
	C4DOS.Ge.Print(tmp);
}

/*
void GeDebugOut(const Char* s, ...){
	import std.c.stdio;
	import std.c.stdlib;
	import std.c.stdarg;
	va_list arp;
	va_start(arp, s);

	Char t[2048];

	vsprintf_safe(t, sizeof(t), s, arp);
	C4DOS.Ge.GeDebugOut("%s", t);

	va_end(arp);
}
*/

/*
  // writes data to stream using printf() syntax,
  // returns number of bytes written
  version (Win64)
  size_t printf(const(char)[] format, ...) {
	return vprintf(format, _argptr);
  }
  else version (X86_64)
  size_t printf(const(char)[] format, ...) {
	va_list ap;
	va_start(ap, __va_argsave);
	auto result = vprintf(format, ap);
	va_end(ap);
	return result;
  }
  else
  size_t printf(const(char)[] format, ...) {
	va_list ap;
	ap = cast(va_list) &format;
	ap += format.sizeof;
	return vprintf(format, ap);
  }
*/


private import core.stdc.stdio : printf;
alias GeDebugOut = printf;  //???

/+
void GeDebugOut(const(char)[] format, ...)
{

	version (Win64)
	{
		vprintf(format, _argptr);
	}
	else version (X86_64)
	{
		va_list ap;
		va_start(ap, __va_argsave);
		vprintf(format, ap);
		va_end(ap);
	}
	else
	{
		va_list ap;
		ap = cast(va_list)&format;
		ap += format.sizeof;
		vprintf(format, ap);
	}
}
+/

void GeDebugOut()(auto ref const(String) s){
//	#ifdef _DEBUG
	debug{
		Char* c = s.GetCStringCopy();
		if (c){
			GeDebugOut(c);
			GeFree(c); //DeleteMem(c);
		}
	}//debug
//	#endif
}

void _GeDebugBreak(Int32 line, const Char* file) { C4DOS.Ge.GeDebugBreak(line, cast(Int8*)file); }

Int32 GeGetTimer() { return C4DOS.Ge.GetTimer(); }
Float64 GeGetMilliSeconds() { return C4DOS.Ge.GeGetMilliSeconds(); }

void lSwap (void* adr, Int cnt = 1)  { C4DOS.Ge.lSwap(adr, cnt); }
void wSwap (void* adr, Int cnt = 1)  { C4DOS.Ge.wSwap(adr, cnt); }
void lIntel(void* adr, Int cnt = 1)  { C4DOS.Ge.lIntel(adr, cnt); }
void wIntel(void* adr, Int cnt = 1)  { C4DOS.Ge.wIntel(adr, cnt); }
void lMotor(void* adr, Int cnt = 1)  { C4DOS.Ge.lMotor(adr, cnt); }
void wMotor(void* adr, Int cnt = 1)  { C4DOS.Ge.wMotor(adr, cnt); }
void llSwap (void* adr, Int cnt = 1) { C4DOS.Ge.llSwap(adr, cnt); }
void llIntel(void* adr, Int cnt = 1) { C4DOS.Ge.llIntel(adr, cnt); }
void llMotor(void* adr, Int cnt = 1) { C4DOS.Ge.llMotor(adr, cnt); }

void vlSwap (void* adr, Int32 cnt = 1) {
	static if(__C4D_64BIT) {
		C4DOS.Ge.llSwap(adr, cnt);
	}else{
		C4DOS.Ge.lSwap(adr, cnt);
	}
}

void vlIntel(void* adr, Int32 cnt = 1) {
	static if(__C4D_64BIT) {
		C4DOS.Ge.llIntel(adr, cnt);
	}else{
		C4DOS.Ge.lIntel(adr, cnt);
	}
}
void vlMotor(void* adr, Int32 cnt = 1) {
	static if(__C4D_64BIT) {
		C4DOS.Ge.llMotor(adr, cnt);
	}else{
		C4DOS.Ge.lMotor(adr, cnt);
	}
}

//-----------------------------------
/*
void GeAddBackgroundHandler(BackgroundHandler* handler, void* tdata, Int32 typeclass, Int32 priority) {
	C4DOS.Ge.AddBackgroundHandler(handler, tdata, typeclass, priority);
}
Bool GeRemoveBackgroundHandler(void* tdata, Int32 typeclass){
	return C4DOS.Ge.RemoveBackgroundHandler(tdata, typeclass);
}
*/

void GeStopBackgroundThreads(Int32 typeclass, BACKGROUNDHANDLERFLAGS flags){
	C4DOS.Ge.StopBackgroundThreads(typeclass, flags);
}
Bool GeCheckBackgroundThreadsRunning(Int32 typeclass, Bool all){
	return C4DOS.Ge.CheckBackgroundThreadsRunning(typeclass, all);
}
void GeProcessBackgroundThreads(Int32 typeclass) {
	C4DOS.Ge.ProcessBackgroundThreads(typeclass);
}
void GeShowMouse(Int32 v) {
	C4DOS.Ge.ShowMouse(v);
}
Bool GeGetScreenDimensions(Int32 x, Int32 y, Bool whole_screen, Int32* sx1, Int32* sy1, Int32* sx2, Int32* sy2){
	return C4DOS.Ge.GetScreenDimensions(x, y, whole_screen, sx1, sy1, sx2, sy2);
}

String GeGetLineEnd(){
	String str;
	C4DOS.Ge.GetLineEnd(&str);
	return str;
}

Int32 GeGetDefaultFPS(){
	return C4DOS.Ge.GetDefaultFPS();
}

/*GEMB_R GeOutString(ref const(String) str, GEMB flags){
	return C4DOS.Ge.OutString(&str, flags);
}*/

OPERATINGSYSTEM GeGetCurrentOS(){
	return C4DOS.Ge.GetCurrentOS();
}

BYTEORDER GeGetByteOrder(){
	return C4DOS.Ge.GetByteOrder();
}

void GeGetGray(Int32* r, Int32* g, Int32* b){
	C4DOS.Ge.GetGray(r, g, b);
}

Bool GeChooseColor(Vector* col, Int32 flags){
	return C4DOS.Ge.ChooseColor(col, flags);
}

Bool GeOpenHTML(ref const(String) webaddress){
	return C4DOS.Ge.OpenHTML(webaddress);
}

Bool GeChooseFont(BaseContainer* bc){
	return C4DOS.Ge.ChooseFont(bc);
}

struct SerialInfo
{
	String nr, name, organization, street, city, country;
};

void GeGetSerialInfo(SERIALINFO type, SerialInfo* si){
	C4DOS.Ge.GetSerialInfo(type, &si.nr, &si.name, &si.organization, &si.street, &si.city, &si.country);
}

Int32 GetC4DVersion() { return C4DOS.c4d_api_version; }

VERSIONTYPE GeGetVersionType(){
	return C4DOS.Ge.GetVersionType();
}
Bool IsNet() { VERSIONTYPE t = GeGetVersionType(); return t == VERSIONTYPE_NET_CLIENT || t == VERSIONTYPE_NET_SERVER_3 || t == VERSIONTYPE_NET_SERVER_UNLIMITED; }
Bool IsServer() { VERSIONTYPE t = GeGetVersionType(); return t == VERSIONTYPE_NET_SERVER_3 || t == VERSIONTYPE_NET_SERVER_UNLIMITED; }
Bool IsClient() { VERSIONTYPE t = GeGetVersionType(); return t == VERSIONTYPE_NET_CLIENT; }

SYSTEMINFO GeGetSystemInfo(){
	return C4DOS.Ge.GetSystemInfo();
}

Bool GeRegisterPlugin(PLUGINTYPE type, Int32 id,ref const(String) str, void* data, Int32 datasize){
	return C4DOS.Ge.RegisterPlugin(API_VERSION, type, id, &str, data, datasize);
}

/*void GePrint(ref const(String) str){
	C4DOS.Ge.Print(str);
}*/

void GePrintNoCR(ref const(String) str){
	C4DOS.Ge.PrintNoCR(str);
}

/*void GeConsoleOut(ref const(String) str){
	String s = String("\x01") + str;
	C4DOS.Ge.Print(s);
}*/

void SetMousePointer(Int32 l){
	C4DOS.Ge.SetMousePointer(l);
}

Bool ShowBitmap(ref const(Filename) fn){
	return C4DOS.Ge.ShowBitmap1(&fn);
}

Bool ShowBitmap(BaseBitmap* bm){
	return C4DOS.Ge.ShowBitmap2(bm);
}

void StopAllThreads(){
	C4DOS.Ge.StopAllThreads();
}

Bool ShutdownThreads(Bool shutdown){
	return C4DOS.Ge.ShutdownThreads(shutdown);
}

void StatusClear(){
	C4DOS.Ge.StatusClear();
}

void StatusSetSpin(){
	C4DOS.Ge.StatusSetSpin();
}

void StatusSetBar(Int32 p){
	C4DOS.Ge.StatusSetBar(p);
}

void StatusSetText(ref const(String) str){
	C4DOS.Ge.StatusSetText(&str);
}

static if(API_VERSION >= 15000) { //R15 only

	void StatusNetClear(){
		C4DOS.Ge.StatusNetClear();
	}

	void StatusSetNetLoad(STATUSNETSTATE status){
		C4DOS.Ge.StatusSetNetLoad(status);
	}

	void StatusSetNetBar(Int32 p, ref const(GeData) dat){
		C4DOS.Ge.StatusSetNetBar(p, dat);
	}

	void StatusSetNetText(ref const(String) str){
		C4DOS.Ge.StatusSetNetText(&str);
	}

	void SaveWorldPreferences(){	C4DOS.Ge.SaveWorldPreferences();	}

	Filename GeFilterSetSuffix(ref const(Filename) name, Int32 id){
		return C4DOS.Ge.FilterSetSuffix(name, id);
	}

	String GetMacModel(ref const(String) machinemodel){
		return C4DOS.Ge.GetMacModel(machinemodel);
	}

	UInt32 GeGetCinemaInfo(CINEMAINFO info){
		return (*C4DOS.Ge.GetCinemaInfo)(info);
	}

	void SetExitCode(Int32 exitCode){
		(*C4DOS.Ge.SetExitCode)(exitCode);
	}

}  //R15 only

void SpecialEventAdd(Int32 messageid, UInt p1, UInt p2){
	C4DOS.Ge.SpecialEventAdd(messageid, p1, p2);
}

void EventAdd(EVENT flags){
	C4DOS.Ge.EventAdd(flags);
}

Bool GeSyncMessage(Int32 messageid, Int32 destid, UInt p1, UInt p2){
	return C4DOS.Ge.SyncMessage(messageid, destid, p1, p2);
}

Bool DrawViews(DRAWFLAGS flags, BaseDraw* bd){
	return C4DOS.Ge.DrawViews(flags, bd);
}

Bool SendModelingCommand(Int32 command,ref ModelingCommandData data){
	return C4DOS.Ge.SendModelingCommand(command, data);
}

Filename GetGlobalTexturePath(Int32 i){
	Filename fn;
	C4DOS.Ge.GetGlobalTexturePath(i, &fn);
	return fn;
}

void SetGlobalTexturePath(Int32 i, ref const(Filename) fn){
	C4DOS.Ge.SetGlobalTexturePath(i, &fn);
}

Bool IsInSearchPath(ref const(Filename) texfilename, ref const(Filename) docpath){
	return C4DOS.Ge.IsInSearchPath(texfilename, docpath);
}

/*Bool GenerateTexturePath(ref const(Filename) docpath, ref const(Filename) srcname, ref const(Filename) suggestedfolder, Filename* dstname, NetRenderService* service, BaseThread* bt){
	return C4DOS.Ge.GenerateTexturePath(docpath, srcname, suggestedfolder, dstname, service, bt);
}*/

void FlushTexture(ref const(Filename) docpath, ref const(String) name, ref const(Filename) suggestedfolder){
	C4DOS.Ge.FlushTexture(&docpath, &name, suggestedfolder);
}

void FlushUnusedTextures(){
	C4DOS.Ge.FlushUnusedTextures();
}


BaseContainer* GetToolPluginData(BaseDocument* doc, Int32 id){
	return C4DOS.Ge.GetToolPluginData(doc, id);
}

BaseContainer* GetWorldPluginData(Int32 id){
	return C4DOS.Ge.GetWorldPluginData(id);
}

Bool SetWorldPluginData(Int32 id, ref const(BaseContainer) bc, Bool add){
	return C4DOS.Ge.SetWorldPluginData(id, &bc, add);
}


BaseContainer GetWorldContainer(){
	BaseContainer bc = NOTOK;
	C4DOS.Ge.GetWorldContainer(&bc);
	return bc;
}

BaseContainer* GetWorldContainerInstance(){
	return C4DOS.Ge.GetWorldContainerInstance();
}

void SetWorldContainer(ref const(BaseContainer) bc){
	C4DOS.Ge.SetWorldContainer(&bc);
}

Vector GetViewColor(Int32 colid){
	return C4DOS.Ge.GetColor(colid);
}

void SetViewColor(Int32 colid, ref const(Vector) col){
	C4DOS.Ge.SetViewColor(colid, col);
}

void ErrorStringDialog(CHECKVALUERANGE type, Float x, Float y, CHECKVALUEFORMAT cvf){
	C4DOS.Ge.ErrorStringDialog(type, x, y, cvf);
}

Bool ReadPluginInfo(Int32 pluginid, void* buffer, Int32 size){
	return C4DOS.Ge.ReadPluginInfo(pluginid, cast(Int8*)buffer, size);
}

Bool WritePluginInfo(Int32 pluginid, void* buffer, Int32 size){
	return C4DOS.Ge.WritePluginInfo(pluginid, cast(Int8*)buffer, size);
}

Bool ReadRegInfo(Int32 pluginid, void* buffer, Int32 size){
	return C4DOS.Ge.ReadPluginReg(pluginid, cast(Int8*)buffer, size);
}

Bool WriteRegInfo(Int32 pluginid, void* buffer, Int32 size){
	return C4DOS.Ge.WritePluginReg(pluginid, cast(Int8*)buffer, size);
}

Bool GeGetMovieInfo(ref const(Filename) fn, Int32* frames, Float* fps){
	return C4DOS.Ge.GetMovieInfo(&fn, frames, fps);
}

Bool GeRegistryAdd(Int32 sub_id, REGISTRYTYPE main_id, void* data){
	return C4DOS.Ge.RegistryAdd(sub_id, main_id, data);
}

Bool GeRegistryRemove(Int32 sub_id, REGISTRYTYPE main_id){
	return C4DOS.Ge.RegistryRemove(sub_id, main_id);
}

Registry* GeRegistryFind(Int32 sub_id, REGISTRYTYPE main_id){
	return C4DOS.Ge.RegistryFind(sub_id, main_id);
}

Registry* GeRegistryGetLast(REGISTRYTYPE main_id){
	return C4DOS.Ge.RegistryGetLast(main_id);
}

Registry* GeRegistryGetFirst(REGISTRYTYPE main_id){
	return C4DOS.Ge.RegistryGetFirst(main_id);
}

Bool GeRegistryGetAutoID(Int32* id){
	return C4DOS.Ge.RegistryGetAutoID(id);
}

struct Registry //: public GeListNode
{
private:
	@disable this();//Registry();
	@disable this(this);
	//~Registry();

public:
	Registry* GetNext() { return cast(Registry*)C4DOS.At.GetNext(cast(GeListNode*)&this); }
	Registry* GetPred() { return cast(Registry*)C4DOS.At.GetPred(cast(GeListNode*)&this); }

	REGISTRYTYPE GetMainID() {
		REGISTRYTYPE main_id;
		Int32				 sub_id;
		void*				 data;
		if (!C4DOS.Ge.RegistryGetData(&this, &main_id, &sub_id, &data))
			return REGISTRYTYPE_ANY;
		return main_id;
	}
	Int32 GetSubID() {
		REGISTRYTYPE main_id;
		Int32		sub_id;
		void*		data;
		if (!C4DOS.Ge.RegistryGetData(&this, &main_id, &sub_id, &data))
			return 0;
		return sub_id;
	}
	void* GetData()	{
		REGISTRYTYPE main_id;
		Int32		sub_id;
		void*		 data;
		if (!C4DOS.Ge.RegistryGetData(&this, &main_id, &sub_id, &data))
			return nullptr;
		return data;
	}
};


Bool RenameDialog(String* str){
	return C4DOS.Ge.RenameDialog(str);
}
/*
Bool LassoSelection::Start(GeDialog& dlg, Int32 mode, Int32 start_x, Int32 start_y, Int32 start_button, Int32 sx1, Int32 sy1, Int32 sx2, Int32 sy2)
{
	return C4DOS.Cd->LSStart(this, (CBaseFrame*)dlg.Get(), mode, start_x, start_y, start_button, sx1, sy1, sx2, sy2);
}

Bool LassoSelection::Start(GeUserArea& ua, Int32 mode, Int32 start_x, Int32 start_y, Int32 start_button, Int32 sx1, Int32 sy1, Int32 sx2, Int32 sy2)
{
	return C4DOS.Cd->LSStart(this, (CBaseFrame*)ua.Get(), mode, start_x, start_y, start_button, sx1, sy1, sx2, sy2);
}

Bool LassoSelection::Start(EditorWindow* win, Int32 mode, Int32 start_x, Int32 start_y, Int32 start_button, Int32 sx1, Int32 sy1, Int32 sx2, Int32 sy2)
{
	return C4DOS.Cd->LSStart(this, (CBaseFrame*)win, mode, start_x, start_y, start_button, sx1, sy1, sx2, sy2);
}

Bool LassoSelection::GetRectangle(Float& x1, Float& y1, Float& x2, Float& y2)
{
	return C4DOS.Cd->LSGetRectangle(this, x1, y1, x2, y2);
}

Bool LassoSelection::CheckSingleClick()
{
	return C4DOS.Cd->LSCheckSingleClick(this);
}

Bool LassoSelection::Test(Int32 x, Int32 y)
{
	return C4DOS.Cd->LSTest(this, x, y);
}

Bool LassoSelection::TestPolygon(ref const(Vector) pa, ref const(Vector) pb, ref const(Vector) pc, ref const(Vector) pd)
{
	return C4DOS.Cd->LSTestPolygon(this, pa, pb, pc, pd);
}

Int32 LassoSelection::GetMode()
{
	return C4DOS.Cd->LSGetMode(this);
}

LassoSelection* LassoSelection::Alloc()
{
	return C4DOS.Cd->LSAlloc();
}

void LassoSelection::Free(LassoSelection*& ls)
{
	C4DOS.Cd->LSFree(ls);
	ls = nullptr;
}
*/
void FindInManager(BaseList2D* bl){
	C4DOS.Ge.FindInManager(bl);
}

void GeSleep(Int32 milliseconds){
	C4DOS.Ge.GeSleep(milliseconds);
}

Bool GeIsMainThread(){
	return C4DOS.Ge.IsMainThread();
}

Bool GeIsActiveToolEnabled(){
	return C4DOS.Ge.IsActiveToolEnabled();
}

GeListHead* GetScriptHead(Int32 type){
	return C4DOS.Ge.GetScriptHead(type);
}


Bool GetCommandLineArgs(ref C4DPL_CommandLineArgs args){
	return C4DOS.Ge.GetCommandLineArgs(args);
}

Int32 GetDynamicScriptID(BaseList2D* bl){
	return C4DOS.Ge.GetDynamicScriptID(bl);
}

Bool GeGetLanguage(Int32 index, String* extension, String* name, Bool* default_language){
	return C4DOS.Ge.GetLanguage(index, extension, name, default_language);
}



IDENTIFYFILE GeIdentifyFile(ref const(Filename) name, UChar* probe, Int32 probesize, IDENTIFYFILE recognition, BasePlugin** bp){
	return C4DOS.Ge.IdentifyFile(name, probe, probesize, recognition, bp);
}

GeData SendCoreMessage()(Int32 coreid,auto ref const(BaseContainer) msg, Int32 eventid){ //! auto ref
	return C4DOS.Ge.SendCoreMessage(coreid, msg, eventid);
}



enum COREMSG_CINEMA								   = C4D_FOUR_BYTE('C','M','c','i');//'CMci';	// request to C4D core

enum COREMSG_CINEMA_GETMACHINEFEATURES             = C4D_FOUR_BYTE('g','O','G','L');	//'gOGL';
enum OPENGL_SUPPORT_DUALPLANE_ARB                  = 1001;
enum OPENGL_SUPPORT_DUALPLANE_KTX                  = 1002;
enum OPENGL_EXTENSION_STRING                       = 1003;
enum OPENGL_SUPPORT_GL_EXT_SEPARATE_SPECULAR_COLOR = 1004;
enum OPENGL_SUPPORT_ENHANCED                       = 1005;
enum OPENGL_RENDERER_NAME                          = 1006;
enum OPENGL_VERSION_STRING                         = 1007;
enum OPENGL_VENDOR_NUM                             = 1008;
enum OPENGL_VENDOR_UNKNOWN                         = 0;
enum OPENGL_VENDOR_NVIDIA                          = 1;
enum OPENGL_VENDOR_ATI                             = 2;
enum OPENGL_VENDOR_INTEL                           = 3;
enum OPENGL_VENDOR_APPLE                           = 4;
enum OPENGL_VENDOR_NAME                            = 1009;
enum OPENGL_SHADING_LANGUAGE_VERSION_STRING        = 1010;
enum OPENGL_VERTEXBUFFER_OBJECT                    = 1011;
enum OPENGL_FRAMEBUFFER_OBJECT                     = 1012;
enum OPENGL_MULTITEXTURE                           = 1013;
enum OPENGL_MAX_2DTEXTURE_SIZE                     = 1014;
enum OPENGL_MAX_3DTEXTURE_SIZE                     = 1015;
enum OPENGL_MAX_TEXCOORD                           = 1016;
enum OPENGL_MAX_TEX_IMAGE_UNITS_VERTEX             = 1017;
enum OPENGL_MAX_TEX_IMAGE_UNITS_FRAGMENT           = 1018;
enum OPENGL_MAX_VP_INSTRUCTIONS                    = 1019;
enum OPENGL_MAX_FP_INSTRUCTIONS                    = 1020;
enum OPENGL_FLOATINGPOINT_TEXTURE                  = 1021;
enum OPENGL_NONPOWEROF2_TEXTURE                    = 1022;
enum OPENGL_DEPTH_TEXTURE                          = 1023;
enum OPENGL_CG_TOOLKIT                             = 1024;
enum OPENGL_MAX_TEXTURE_INDIRECTIONS               = 1025;
enum OPENGL_CG_LATEST_VERTEX_PROFILE               = 1026;
enum OPENGL_CG_LATEST_FRAGMENT_PROFILE             = 1027;
enum OPENGL_CG_LATEST_VERTEX_PROFILE_NAME          = 1028;
enum OPENGL_CG_LATEST_FRAGMENT_PROFILE_NAME        = 1029;
enum OPENGL_DRIVER_VERSION_STRING                  = 1030;	// only supported on Windows
enum OPENGL_CG_VERSION_STRING                      = 1031;
enum OPENGL_FBO_Z_DEPTH                            = 1033;
enum OPENGL_FRAMEBUFFER_OBJECT_MULTISAMPLE         = 1034;	// Int32 - max. samples
enum OPENGL_MAX_ELEMENT_VERTICES                   = 1035;
enum OPENGL_MAX_ELEMENT_INDICES                    = 1036;
enum OPENGL_MAX_TEX_IMAGE_UNITS_GEOMETRY           = 1037;
enum OPENGL_CG_LATEST_GEOMETRY_PROFILE             = 1038;
enum OPENGL_CG_LATEST_GEOMETRY_PROFILE_NAME        = 1039;
enum OPENGL_VERSION_INT                            = 1040;
enum OPENGL_GLSL_VERSION_INT                       = 1041;
enum OPENGL_MAX_RENDERBUFFER_SAMPLES               = 1042;
enum OPENGL_RENDERBUFFER_MASK                      = 1043;	// UInt64
enum OPENGL_RENDER_TO_FP16_TEXTURE                 = 1044;
enum OPENGL_RENDER_TO_FP32_TEXTURE                 = 1045;
enum OPENGL_STEREO_BUFFER                          = 1046;
enum OPENGL_DRIVER_OUTDATED                        = 1047;	// only supported on Windows
enum OPENGL_SUPPORT_PRIMITIVERESTARTINDEX          = 1048;
enum OPENGL_SUPPORT_GEOMETRYSHADER                 = 1049;
enum OPENGL_SUPPORT_OSX_10_7                       = 1050;

enum MACHINEINFO_OSTYPE                            = 2000;
enum MACHINEINFO_OSVERSION                         = 2001;
enum MACHINEINFO_PROCESSORTYPE                     = 2002;
enum MACHINEINFO_PROCESSORNAME                     = 2003;
enum MACHINEINFO_PROCESSORFEATURES                 = 2004;
enum MACHINEINFO_NUMBEROFPROCESSORS                = 2005;
enum MACHINEINFO_MACHINEMODEL                      = 2006;
enum MACHINEINFO_COMPUTERNAME                      = 2007;
enum MACHINEINFO_USERNAME                          = 2008;
enum MACHINEINFO_PROCESSORSPEED_MHZ                = 2009;	// Float, MHz
enum MACHINEINFO_C4DBUILDID                        = 2010;	// String
enum MACHINEINFO_C4DTYPE                           = 2011;	// String
enum MACHINEINFO_PROCESSORHTCOUNT                  = 2012;	// Int32, number of logical processors per core, 1= =no ht
enum MACHINEINFO_PHYSICAL_RAM_SIZE                 = 2013;	// Int64, physical memory size

enum MACHINEINFO_LOADEDPLUGINS                     = 3000;

BaseContainer GetMachineFeatures(){
	GeData dat = SendCoreMessage(COREMSG_CINEMA, BaseContainer(COREMSG_CINEMA_GETMACHINEFEATURES), 0);
	if (!dat.GetContainer())
		return BaseContainer(NOTOK);
	return *dat.GetContainer();
}

Bool GePluginMessage(Int32 id, void* data){
	return C4DOS.Ge.PluginMessage(id, data);
}

Bool CheckIsRunning(CHECKISRUNNING type){
	return C4DOS.Ge.CheckIsRunning(type);
}

String GeGetDefaultFilename(Int32 id){
	return C4DOS.Ge.GetDefaultFilename(id).GetString();
}

String GetObjectName(Int32 type){
	return C4DOS.Ge.GetObjectName(type);
}

String GetTagName(Int32 type){
	return C4DOS.Ge.GetTagName(type);
}

Int32 GetObjectType(ref const(String) name){
	return C4DOS.Ge.GetObjectType(name);
}

Int32 GetTagType(ref const(String) name){
	return C4DOS.Ge.GetTagType(name);
}

Bool GeGetMemoryStat(ref BaseContainer stat){
	return C4DOS.Ge.GeGetMemoryStat(stat);
}

Bool PopupEditText(Int32 screenx, Int32 screeny, Int32 width, Int32 height, ref const(String) changeme, Int32 flags, PopupEditTextCallback* func, void* userdata){
	return C4DOS.Ge.PopupEditText(screenx, screeny, width, height, changeme, flags, func, userdata);
}

void StartEditorRender(Bool active_only, Bool raybrush, Int32 x1, Int32 y1, Int32 x2, Int32 y2, BaseThread* bt, BaseDraw* bd, Bool newthread){
	C4DOS.Ge.StartEditorRender(active_only, raybrush, x1, y1, x2, y2, bt, bd, newthread);
}

String FormatNumber(ref const(GeData) val, Int32 format, Int32 fps, Bool bUnit){
	return C4DOS.Ge.FormatNumber(val, format, fps, bUnit, nullptr);
}

GeData StringToNumber(ref const(String) text, Int32 format, Int32 fps, const LENGTHUNIT* lengthunit){
	return C4DOS.Ge.StringToNumber(text, format, fps, lengthunit);
}

Int32	GeDebugSetFloatingPointChecks(Int32 on){
	return C4DOS.Ge.GeDebugSetFloatingPointChecks(on);
}

String GeGetDegreeChar(){
	return C4DOS.Ge.GeGetDegreeChar();
}

String GeGetPercentChar(){
	return C4DOS.Ge.GeGetPercentChar();
}

enum COREMSG_CINEMA_GETCOMMANDNAME =		200000033;
enum COREMSG_CINEMA_GETCOMMANDENABLED =		200000035;
enum COREMSG_CINEMA_GETCOMMANDCHECKED =		300000115;
enum COREMSG_CINEMA_EXECUTEEDITORCOMMAND =	200000023;
enum COREMSG_CINEMA_EXECUTESUBID =			300001036;
enum COREMSG_CINEMA_EXECUTEOPTIONMODE =		300001037;
enum COREMSG_CINEMA_GETCOMMANDHELP =		200000234;

enum COREMSG_CINEMA_FORCE_AM_UPDATE =		1001077;	// CoreMesage: Force AM update
enum COREMSG_UPDATECOMMANDSMESSAGE =		200000100;

void CallCommand(Int32 id, Int32 subid){
	if (!GeIsMainThread())
		return;
	BaseContainer msg = (COREMSG_CINEMA_EXECUTEEDITORCOMMAND);
	msg.SetInt32(COREMSG_CINEMA_EXECUTEEDITORCOMMAND, id);
	msg.SetInt32(COREMSG_CINEMA_EXECUTESUBID, subid);
	SendCoreMessage(COREMSG_CINEMA, msg, 0);
}
/*
String GetCommandName(Int32 id){
	if (!GeIsMainThread())
		return String();
	BaseContainer msg = (COREMSG_CINEMA_GETCOMMANDNAME);
	msg.SetInt32(COREMSG_CINEMA_GETCOMMANDNAME, id);
	return SendCoreMessage(COREMSG_CINEMA, msg, 0).GetString();
}

String GetCommandHelp(Int32 id){
	if (!GeIsMainThread())
		return String();
	BaseContainer msg = (COREMSG_CINEMA_GETCOMMANDHELP);
	msg.SetInt32(COREMSG_CINEMA_GETCOMMANDHELP, id);
	return SendCoreMessage(COREMSG_CINEMA, msg, 0).GetString();
}
*/
Bool IsCommandEnabled(Int32 id){
	if (!GeIsMainThread())
		return false;
	BaseContainer msg = (COREMSG_CINEMA_GETCOMMANDENABLED);
	msg.SetInt32(COREMSG_CINEMA_GETCOMMANDENABLED, id);
	return SendCoreMessage(COREMSG_CINEMA, msg, 0).GetInt32();
}

Bool IsCommandChecked(Int32 id){
	if (!GeIsMainThread())
		return false;
	BaseContainer msg = (COREMSG_CINEMA_GETCOMMANDCHECKED);
	msg.SetInt32(COREMSG_CINEMA_GETCOMMANDCHECKED, id);
	return SendCoreMessage(COREMSG_CINEMA, msg, 0).GetInt32();
}

Bool SendMailAvailable(){
	return C4DOS.Ge.SendMailAvailable();
}

Bool SendMail(ref const(String) t_subject, const String* t_to, const String* t_cc, const String* t_bcc, Filename* t_attachments, ref const(String) t_body, Int32 flags){
	return C4DOS.Ge.SendMail(t_subject, t_to, t_cc, t_bcc, t_attachments, t_body, flags);
}

Bool GetSystemEnvironmentVariable(ref const(String) varname,ref String result){
	return C4DOS.Ge.GetSystemEnvironmentVariable(varname, result);
}

Int32 GetShortcutCount(){
	return C4DOS.Ge.GetShortcutCount();
}

BaseContainer GetShortcut(Int32 index){
	return C4DOS.Ge.GetShortcut(index);
}

Bool AddShortcut(ref const(BaseContainer) bc){
	return C4DOS.Ge.AddShortcut(bc);
}

Bool RemoveShortcut(Int32 index){
	return C4DOS.Ge.RemoveShortcut(index);
}

Bool LoadShortcutSet(ref const(Filename) fn, Bool add){
	return C4DOS.Ge.LoadShortcutSet(fn, add);
}

Bool SaveShortcutSet(ref const(Filename) fn){
	return C4DOS.Ge.SaveShortcutSet(fn);
}

Int32 FindShortcutsFromID(Int32 pluginid, Int32* indexarray, Int32 maxarrayelements){
	return C4DOS.Ge.FindShortcutsFromID(pluginid, indexarray, maxarrayelements);
}

Int32 FindShortcuts(ref const(BaseContainer) scut, Int32* idarray, Int32 maxarrayelements){
	return C4DOS.Ge.FindShortcuts(scut, idarray, maxarrayelements);
}

Bool CheckCommandShortcut(Int32 id, Int32 key, Int32 qual){
	return C4DOS.Ge.CheckCommandShortcut(id, key, qual);
}

void InsertCreateObject(BaseDocument* doc, BaseObject* op, BaseObject* activeobj){
	C4DOS.Ge.InsertCreateObject(doc, op, activeobj);
}



void CopyToClipboard(ref const(String) text){
	(*C4DOS.Ge.CopyToClipboard)(text);
}

void CopyToClipboard(BaseBitmap* map, Int32 ownerid){
	(*C4DOS.Ge.CopyToClipboardB)(map, ownerid);
}

Bool GetStringFromClipboard(String* txt){
	return (*C4DOS.Ge.GetStringFromClipboard)(txt);
}

Bool GetBitmapFromClipboard(BaseBitmap* map){
	return (*C4DOS.Ge.GetBitmapFromClipboard)(map);
}

CLIPBOARDTYPE GetClipboardType(){
	return (*C4DOS.Ge.GetClipboardType)();
}

Int32 GetC4DClipboardOwner(){
	return (*C4DOS.Ge.GetC4DClipboardOwner)();
}

Bool AskForAdministratorPrivileges(ref const(String) msg, ref const(String) caption, Bool allowsuperuser, void** token){
	return (*C4DOS.Ge.AskForAdministratorPrivileges)(msg, caption, allowsuperuser, token);
}

void EndAdministratorPrivileges(){
	(*C4DOS.Ge.EndAdministratorPrivileges)();
}

void RestartApplication(const UInt16* param, Int32 exitcode, const UInt16** path){
	(*C4DOS.Ge.RestartApplication)(param, exitcode, path);
}



void BrowserLibraryPopup(Int32 mx, Int32 my, Int32 defw, Int32 defh, Int32 pluginwindowid, Int32 presettypeid, void* userdata, BrowserPopupCallback callback){
	return C4DOS.Ge.BrowserLibraryPopup(mx, my, defw, defh, pluginwindowid, presettypeid, userdata, callback);
}

void GeUpdateUI(){
	C4DOS.Ge.GeUpdateUI();
}

BaseBitmap* GetCursorBitmap(Int32 type,ref Int32 hotspotx,ref Int32 hotspoty){
	return C4DOS.Ge.GetCursorBitmap(type, hotspotx, hotspoty);
}
/*
ModelingCommandData::~ModelingCommandData()
{
	AtomArray::Free(result);
}
*/

///File


/+
#include <stdarg.h>
#include <stdio.h>
#include <string.h>

#include "c4d_general.h"
#include "c4d_shader.h"
#include "c4d_file.h"
#include "c4d_basecontainer.h"
#include "c4d_gui.h"

Bool ParserCache::CopyTo(ParserCache* dest)
{
	return C4DOS.Pr->CopyPCache(this, dest);
}

ParserCache* ParserCache::Alloc()
{
	return C4DOS.Pr->AllocPCache();
}

void ParserCache::Free(ParserCache*& p)
{
	C4DOS.Pr->FreePCache(p);
	p = nullptr;
}

Parser* Parser::Alloc()
{
	return C4DOS.Pr->Alloc();
}

void Parser::Free(Parser*& pr)
{
	C4DOS.Pr->Free(pr);
	pr = nullptr;
}

Bool Parser::AddVar(ref const(String) str, Float* value, Bool case_sensitive)
{
	return C4DOS.Pr->AddVar(this, &str, value, case_sensitive);
}

Bool Parser::RemoveVar(ref const(String) s, Bool case_sensitive)
{
	return C4DOS.Pr->RemoveVar(this, &s, case_sensitive);
}

Bool Parser::RemoveAllVars()
{
	return C4DOS.Pr->RemoveAllVars(this);
}

void Parser::GetParserData(ParserCache* p)
{
	return C4DOS.Pr->GetParserData(this, p);
}

Bool Parser::Init(ref const(String) s, Int32* error, Int32 unit, Int32 angle_unit, Int32 base)
{
	return C4DOS.Pr->Init(this, &s, error, unit, angle_unit, base);
}

Bool Parser::Eval(ref const(String) str, Int32* error, Float* res, Int32 unit, Int32 angletype, Int32 basis)
{
	return C4DOS.Pr->Eval(this, &str, error, res, unit, angletype, basis);
}

Bool Parser::ReEval(Float* result, Int32* error)
{
	return C4DOS.Pr->ReEval(this, result, error);
}

Bool Parser::Calculate(const ParserCache* pdat, Float* result, Int32* error)
{
	return C4DOS.Pr->Calculate(this, pdat, result, error);
}

Bool Parser::AddVarLong(ref const(String) str, Int32* value, Bool case_sensitive)
{
	return C4DOS.Pr->AddVarLong(this, &str, value, case_sensitive);
}

Bool Parser::EvalLong(ref const(String) str, Int32* error, Int32* res, Int32 unit, Int32 basis)
{
	return C4DOS.Pr->EvalLong(this, &str, error, res, unit, basis);
}

Bool Parser::ReEvalLong(Int32* result, Int32* error)
{
	return C4DOS.Pr->ReEvalLong(this, result, error);
}

Bool Parser::CalculateLong(const ParserCache* pdat, Int32* result, Int32* error)
{
	return C4DOS.Pr->CalculateLong(this, pdat, result, error);
}

Bool Parser::Reset(ParserCache* p)
{
	return C4DOS.Pr->Reset(this, p);
}

+/
