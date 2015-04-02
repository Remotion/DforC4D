module c4d_basebitmap;

import c4d;
import c4d_os;
import c4d_general;
import c4d_basedata;


alias UChar		PIX;
alias UChar		PIX_C;
alias UInt16	PIX_W;
alias Float32	PIX_F;

// number of color info bits
auto PIX_UCHAR(  ARG1 )(ARG1 p) { return (cast(PIX_C*)p); }
auto PIX_UWORD(  ARG1 )(ARG1 p) { return (cast(PIX_W*)p); }
auto PIX_FLOAT(  ARG1 )(ARG1 p) { return (cast(PIX_F*)p); }

auto B3D_BITDEPTH(  ARG1 )(ARG1 mode) { return	 ((mode >> BITDEPTH_SHIFT) & (BITDEPTH_UCHAR | BITDEPTH_UWORD | BITDEPTH_FLOAT)); }
auto B3D_COLOR_MODE(  ARG1 )(ARG1 mode) { return (COLORMODE(cast(Int32)mode & ~((BITDEPTH_UCHAR | BITDEPTH_UWORD | BITDEPTH_FLOAT) << BITDEPTH_SHIFT))); }

auto B3D_SETDEPTH(  ARG1 )(ARG1 depth) { return	(COLORMODE(depth << BITDEPTH_SHIFT)); }

auto B3D_IS_CHAR(  ARG1 )(ARG1 mode) { return	 (B3D_BITDEPTH(mode) == BITDEPTH_UCHAR); }
auto B3D_IS_UWORD(  ARG1 )(ARG1 mode) { return (B3D_BITDEPTH(mode) == BITDEPTH_UWORD); }
auto B3D_IS_FLOAT(  ARG1 )(ARG1 mode) { return (B3D_BITDEPTH(mode) == BITDEPTH_FLOAT); }

enum COLORMODE_MAXCOLOR = ((1 << 6) - 1);

enum COLORBYTES_GRAY  = 1;
enum COLORBYTES_AGRAY = 2;
enum COLORBYTES_RGB   = 3;
enum COLORBYTES_ARGB  = 4;
enum COLORBYTES_CMYK  = 4;
enum COLORBYTES_ACMYK = 5;

enum COLORBYTES_GRAYw	= (COLORBYTES_GRAY  * (PIX_W.sizeof));	// 16bit GREY
enum COLORBYTES_AGRAYw	= (COLORBYTES_AGRAY * (PIX_W.sizeof));	// 16bit GREY+ALPHA
enum COLORBYTES_RGBw	= (COLORBYTES_RGB   * (PIX_W.sizeof));	// 16bit RGBs
enum COLORBYTES_ARGBw	= (COLORBYTES_ARGB  * (PIX_W.sizeof));	// 16bit RGBAs
enum COLORBYTES_GRAYf	= (COLORBYTES_GRAY  * (PIX_F.sizeof));	// float GREY
enum COLORBYTES_AGRAYf	= (COLORBYTES_AGRAY * (PIX_F.sizeof));	// float GREY+ALPHA
enum COLORBYTES_RGBf	= (COLORBYTES_RGB   * (PIX_F.sizeof));	// float RGBs
enum COLORBYTES_ARGBf	= (COLORBYTES_ARGB  * (PIX_F.sizeof));	// float RGBAs

enum COLORBYTES_MAX = COLORBYTES_ARGBf;

enum BASEBITMAP_DATA_GUIPIXELRATIO   =	100;	//Real
enum BASEBITMAP_DATA_NAME            =	1003;	//String
enum BASEBITMAP_DATA_PROGRESS_TIME   =	1004;	//String
enum BASEBITMAP_DATA_PROGRESS_ACTION =	1005;	//String
enum BASEBITMAP_DATA_PROGRESS_FRAME  =	1006;	//Float	(0...1)  frame progress
enum BASEBITMAP_DATA_PROGRESS_SEQ    =	1007;	//Float	(0...1)  sequence progress
enum BASEBITMAP_DATA_PROGRESS_FNUM   =	1008;	//String (1 of 91) (F 1)
enum BASEBITMAP_DATA_DRAW_REGIONS    =	1009;	//container	- contains region info
enum BASEBITMAP_DATA_SPINMODE        =	1010;	//Bool
enum BASEBITMAP_DATA_HOLDTIME        =	1011;	//Int32
enum BASEBITMAP_DATA_STARTTIME       =	1012;	//Int32
enum BASEBITMAP_DATA_PROGRESS_PHASE  =	1013;	//RENDERPROGRESSTYPE
enum BASEBITMAP_DATA_FRAMETIME       =	1015;	//Int32
enum BASEBITMAP_DATA_TEXTURE_ERROR   =	1019;	//String

enum BITMAP_UPDATEREGION
{
	BITMAP_UPDATEREGION_X1			= 1,
	BITMAP_UPDATEREGION_Y1			= 2,
	BITMAP_UPDATEREGION_X2			= 3,
	BITMAP_UPDATEREGION_Y2			= 4,
	BITMAP_UPDATEREGION_TYPE		= 5,
	BITMAP_UPDATEREGION_COLOR		= 6,
	BITMAP_UPDATEREGION_PREPARE = 7
} mixin ENUM_END_LIST!(BITMAP_UPDATEREGION);


//=============================================================================
struct BaseBitmap
{
private:
	@disable this();
	@disable this(this);
	//@disable ~this(); //we can not disable dtor !?

public:
	BaseBitmap* GetClone() const { return C4DOS.Bm.GetClone(&this); }
	BaseBitmap* GetClonePart(Int32 x, Int32 y, Int32 w, Int32 h) const { return C4DOS.Bm.GetClonePart(&this, x, y, w, h); }
	Bool CopyTo(BaseBitmap* dst) const { return C4DOS.Bm.CopyTo(&this, dst); }

	void FlushAll(){ C4DOS.Bm.FlushAll(&this); }

	Int32 GetBw () const { return C4DOS.Bm.GetBw(&this); }
	Int32 GetBh () const { return C4DOS.Bm.GetBh(&this); }
	Int32 GetBt () const { return C4DOS.Bm.GetBt(&this); }
	Int32 GetBpz() const { return C4DOS.Bm.GetBpz(&this); }
	COLORMODE GetColorMode() const { 
		//return cast(COLORMODE)C4DOS.Bm.MPB_GetParameter(cast(const MultipassBitmap*)&this, MPBTYPE_COLORMODE).GetInt32();
		GeData result; C4DOS.Bm.MPB_GetParameter(&result,cast(const MultipassBitmap*)&this, MPBTYPE_COLORMODE); return cast(COLORMODE)result.GetInt32();
	}


	static IMAGERESULT Init(ref BaseBitmap*  res, ref const Filename  name, Int32 frame = -1, Bool* ismovie = nullptr, BitmapLoaderPlugin** loaderplugin = nullptr) { return C4DOS.Bm.Init3(res, name, frame, ismovie, loaderplugin); }
	IMAGERESULT Init(ref const Filename  name, Int32 frame = -1, Bool* ismovie = nullptr) { return C4DOS.Bm.Init2(&this, &name, frame, ismovie); }
	IMAGERESULT Init(Int32 x, Int32 y, Int32 depth = 24, INITBITMAPFLAGS flags = INITBITMAPFLAGS_0) { return C4DOS.Bm.Init1(&this, x, y, depth, flags); }

	IMAGERESULT Save(ref const Filename name, Int32 format,const BaseContainer* data, SAVEBIT savebits) const { return C4DOS.Bm.Save(&this, name, format, data, savebits); }

	void SetCMAP(Int32 i, Int32 r, Int32 g, Int32 b) { C4DOS.Bm.SetCMAP(&this, i, r, g, b); }


	Bool SetPixelCnt(Int32 x, Int32 y, Int32 cnt, UChar* buffer, Int32 inc, COLORMODE srcmode, PIXELCNT flags) { return C4DOS.Bm.SetPixelCnt(&this, x, y, cnt, buffer, inc, srcmode, flags); }
	void GetPixelCnt(Int32 x, Int32 y, Int32 cnt, UChar* buffer, Int32 inc, COLORMODE dstmode, PIXELCNT flags, ColorProfileConvert* conversion = nullptr) const { C4DOS.Bm.GetPixelCnt(&this, x, y, cnt, buffer, inc, dstmode, flags, conversion); }
	
	void ScaleIt(BaseBitmap* dst, Int32 intens, Bool sample, Bool nprop) const { C4DOS.Bm.ScaleIt(&this, dst, intens, sample, nprop); }
	void ScaleBicubic(BaseBitmap* dst, Int32 src_xmin, Int32 src_ymin, Int32 src_xmax, Int32 src_ymax, Int32 dst_xmin, Int32 dst_ymin, Int32 dst_xmax, Int32 dst_ymax) const { C4DOS.Bm.ScaleBicubic(&this, dst, src_xmin, src_ymin, src_xmax, src_ymax, dst_xmin, dst_ymin, dst_xmax, dst_ymax); }

	void SetPen(Int32 r, Int32 g, Int32 b) { C4DOS.Bm.SetPen(&this, r, g, b); }
	void Clear(Int32 r, Int32 g, Int32 b) { C4DOS.Bm.Clear(&this, 0, 0, GetBw() - 1, GetBh() - 1, r, g, b); }
	void Clear(Int32 x1, Int32 y1, Int32 x2, Int32 y2, Int32 r, Int32 g, Int32 b){ C4DOS.Bm.Clear(&this, x1, y1, x2, y2, r, g, b); }
	void Line(Int32 x1, Int32 y1, Int32 x2, Int32 y2) { C4DOS.Bm.Line(&this, x1, y1, x2, y2); }
	void Arc(Int32 x, Int32 y, Float radius, Float angle_start, Float angle_end, Int32 subdiv = 32)	 { C4DOS.Bm.Arc(&this, x, y, radius, angle_start, angle_end, subdiv); }
	Bool SetPixel(Int32 x, Int32 y, Int32 r, Int32 g, Int32 b) { return C4DOS.Bm.SetPixel(&this, x, y, r, g, b); }
	void GetPixel(Int32 x, Int32 y, UInt16* r, UInt16* g, UInt16* b) const { C4DOS.Bm.GetPixel(&this, x, y, r, g, b); }
	BaseBitmap* AddChannel(Bool internal, Bool straight) { return C4DOS.Bm.AddChannel(&this, internal, straight); }
	void RemoveChannel(BaseBitmap* channel){ C4DOS.Bm.RemoveChannel(&this, channel); }
	void GetAlphaPixel(BaseBitmap* channel, Int32 x, Int32 y, UInt16* val) const { C4DOS.Bm.GetAlphaPixel(&this, channel, x, y, val); }
	Bool SetAlphaPixel(BaseBitmap* channel, Int32 x, Int32 y, Int32 val) { return C4DOS.Bm.SetAlphaPixel(&this, channel, x, y, val); }


	BaseBitmap* GetInternalChannel() const { return C4DOS.Bm.GetInternalChannel((cast(BaseBitmap*)&this)); }
	BaseBitmap* GetInternalChannel() { return C4DOS.Bm.GetInternalChannel(&this); }
	Int32	GetChannelCount() const { return C4DOS.Bm.GetChannelCount(&this); }
	BaseBitmap* GetChannelNum(Int32 num) const { return C4DOS.Bm.GetChannelNum(&this, num); }
	BaseBitmap* GetChannelNum(Int32 num) { return C4DOS.Bm.GetChannelNum((cast(BaseBitmap*)&this), num); }

	Bool IsMultipassBitmap() const { return C4DOS.Bm.IsMultipassBitmap(&this); }
	Bool SetData(Int32 id, /*ref const*/in GeData  data) { return C4DOS.Bm.SetBaseBitmapData(&this, id, data); }
	GeData GetData(Int32 id, /*ref const*/in GeData t_default) const { 
		GeData result; C4DOS.Bm.GetBaseBitmapData(&result, &this, id, t_default); return result;
		//return C4DOS.Bm.GetBaseBitmapData(&this, id, t_default);
	}

	static BaseBitmap* Alloc() { return C4DOS.Bm.Alloc(); }
	static void Free(ref BaseBitmap*  bm) { C4DOS.Bm.Free(bm);	bm = null; }

	UInt32 GetDirty() const { return C4DOS.Bm.GetDirty(&this); }
	void SetDirty() { C4DOS.Bm.SetDirty(&this); }

	Bool CopyPartTo(BaseBitmap* dst, Int32 x, Int32 y, Int32 w, Int32 h) const;

	Int GetMemoryInfo() const { return C4DOS.Bm.GetMemoryInfo(&this); }

	BaseBitmap* GetUpdateRegionBitmap() { return C4DOS.Bm.GetUpdateRegionBitmap(&this); }
	BaseBitmap* GetUpdateRegionBitmap() const { return C4DOS.Bm.GetUpdateRegionBitmap(&this); }

	Bool SetColorProfile(const ColorProfile* profile) { return C4DOS.Bm.SetColorProfile(&this, profile); }
	ColorProfile* GetColorProfile() const { return C4DOS.Bm.GetColorProfile(&this); }
};

//=============================================================================
struct MultipassBitmap //: public BaseBitmap
{
private:
	@disable this();
	@disable this(this);
	//@disable ~this(); //we can not disable dtor !?
public:
	BaseBitmap parent; //?
	alias parent this; //? 
public:
	Int32 GetLayerCount() const { return C4DOS.Bm.MPB_GetLayerCount(&this); }
	Int32 GetAlphaLayerCount() const { return C4DOS.Bm.MPB_GetAlphaLayerCount(&this); }
	Int32 GetHiddenLayerCount() const { return C4DOS.Bm.MPB_GetHiddenLayerCount(&this); }
	MultipassBitmap* GetSelectedLayer() { return C4DOS.Bm.MPB_GetSelectedLayer(&this); }
	MultipassBitmap* GetLayerNum(Int32 num) { return C4DOS.Bm.MPB_GetLayerNum(&this, num); }
	MultipassBitmap* GetAlphaLayerNum(Int32 num) { return C4DOS.Bm.MPB_GetAlphaLayerNum(&this, num); }
	MultipassBitmap* GetHiddenLayerNum(Int32 num) { return C4DOS.Bm.MPB_GetHiddenLayerNum(&this, num); }
	MultipassBitmap* AddLayer(MultipassBitmap* insertafter, COLORMODE colormode, Bool hidden = false) { return C4DOS.Bm.MPB_AddLayer(&this, insertafter, colormode, hidden); }
	MultipassBitmap* AddFolder(MultipassBitmap* insertafter, Bool hidden = false) { return C4DOS.Bm.MPB_AddFolder(&this, insertafter, hidden); }
	MultipassBitmap* AddAlpha(MultipassBitmap* insertafter, COLORMODE colormode) { return C4DOS.Bm.MPB_AddAlpha(&this, insertafter, colormode); }
	Bool DeleteLayer(ref MultipassBitmap*  layer) { Bool ret = C4DOS.Bm.MPB_DeleteLayer(&this, layer); layer = nullptr; return ret; }
	MultipassBitmap* FindUserID(Int32 id, Int32 subid = 0) { return C4DOS.Bm.MPB_FindUserID(&this, id, subid); }
	void ClearImageData() { C4DOS.Bm.MPB_ClearImageData(&this); }
	PaintBitmap* GetPaintBitmap() { return C4DOS.Bm.MPB_GetPaintBitmap(&this); }

	void FreeHiddenLayers() { C4DOS.Bm.MPB_FreeHiddenLayers(&this); }

	void SetMasterAlpha(BaseBitmap* master) { C4DOS.Bm.MPB_SetMasterAlpha(&this, master); }
	GeData GetParameter(MPBTYPE id) const {
		GeData result; C4DOS.Bm.MPB_GetParameter(&result,&this, id); return result;
		//return C4DOS.Bm.MPB_GetParameter(&this, id);
	}
	Bool SetParameter(MPBTYPE id, ref const GeData  par) { return C4DOS.Bm.MPB_SetParameter(&this, id, par); }

	static MultipassBitmap* Alloc(Int32 bx, Int32 by, COLORMODE mode) { return C4DOS.Bm.MPB_AllocWrapperPB(bx, by, mode); }
	static MultipassBitmap* AllocWrapper(BaseBitmap* bmp) { return C4DOS.Bm.MPB_AllocWrapper(bmp); }
	static void Free(ref MultipassBitmap*  bm){ C4DOS.Bm.Free(cast(BaseBitmap*)bm);	bm = null; }
/+
	Bool GetLayers(maxon::BaseArray<BaseBitmap*>& list, MPB_GETLAYERS flags = MPB_GETLAYERS_IMAGE | MPB_GETLAYERS_ALPHA);
	Bool GetLayers(maxon::BaseArray<MultipassBitmap*>& list, MPB_GETLAYERS flags = MPB_GETLAYERS_IMAGE | MPB_GETLAYERS_ALPHA);

	Bool SetTempColorProfile(const ColorProfile* profile, Bool dithering);
	Int32	GetUserID(void) const;
	void SetUserID(Int32 id);
	void SetUserSubID(Int32 subid);
	void SetSave(Bool save);
	void SetBlendMode(Int32 mode);
	void SetName(const String& name);
	void SetColorMode(COLORMODE mode);
	void SetComponent(Int32 c);
	void SetDpi(Int32 dpi);
+/
};


//==============================================================================
struct AutoBitmap
{
private:
	BaseBitmap* bmp = null;

public:
	@disable this();
	@disable this(this);

	this(in string str, Float pixelRatio = 1.0) {
		this(String(str),pixelRatio);
	}	

	this(in String str, Float pixelRatio = 1.0) {
		bmp = BaseBitmap.Alloc();
		if (!bmp) return;
		Filename fn = GeGetPluginPath() + Filename(String("res")) + Filename(str);
		if (bmp.Init(fn) != IMAGERESULT_OK)	{
			BaseBitmap.Free(bmp);
			return;
		}
		bmp.SetData(BASEBITMAP_DATA_GUIPIXELRATIO, GeData(pixelRatio));
	}//AutoBitmap(const String& str, Float pixelRatio = 1.0);

	this(Int32 id) { bmp = InitResourceBitmap(id); } //AutoBitmap(Int32 id);
	~this() { /*printf(" ~AutoBitmap %p \n",bmp);*/ BaseBitmap.Free(bmp); } //~AutoBitmap();

	//operator BaseBitmap*() const { return bmp; }

	@property BaseBitmap* Get()  const {  /*printf(" ~Get %p \n",bmp);*/ return cast(BaseBitmap*)bmp; }
	alias Get this;

};


public import lib_iconcollection;

IconData InitResourceIcon(Int32 resource_id)
{
	IconData dat;
	if (!GetIcon(resource_id, &dat) || !dat.bmp)
		return IconData();
	return dat;
}

BaseBitmap* InitResourceBitmap(Int32 resource_id)
{
	IconData dat;
	if (!GetIcon(resource_id, &dat) || !dat.bmp)
		return nullptr;
	return dat.GetClonePart();
}

