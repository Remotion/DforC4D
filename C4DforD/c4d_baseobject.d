
module c4d_baseobject;

import c4d;
import c4d_os;

import c4d_baselist;// : BaseList2D;

//regex:
/// AtCall\((\w+)\)\s*\(
/// C4DOS.At.$1(&this, 

//regex:
/// BoCall\((\w+)\)\s*\(
/// C4DOS.Bo.$1(&this,  

static assert(BaseObject.sizeof == 1); 
//=============================================================================
struct BaseObject // : public BaseList2D
{
	BaseList2D parent; //?
	alias parent this; //? 
private:
	@disable this();//BaseObject();
	//~BaseObject();

public:
	
	BaseObject* GetNext    () { return cast(BaseObject*)C4DOS.At.GetNext(cast(GeListNode*)&this ); }
	BaseObject* GetPred    () { return cast(BaseObject*)C4DOS.At.GetPred(cast(GeListNode*)&this ); }
	BaseObject* GetUp      () { return cast(BaseObject*)C4DOS.At.GetUp(cast(GeListNode*)&this ); }
	BaseObject* GetDown    () { return cast(BaseObject*)C4DOS.At.GetDown(cast(GeListNode*)&this ); }
	BaseObject* GetDownLast() { return cast(BaseObject*)C4DOS.At.GetDownLast(cast(GeListNode*)&this ); }

	//? Float GetVisibility(Float parent);

	Vector GetAbsPos() const { Vector res=void; C4DOS.Bo.GetAbsPos(&this,&res); return res; }
	void SetAbsPos(in Vector v) { C4DOS.Bo.SetAbsPos(&this, v); }
	void SetAbsPos(ref const Vector v) { C4DOS.Bo.SetAbsPos(&this, v); }

	Vector GetAbsScale() const { Vector res=void; C4DOS.Bo.GetAbsScale(&this,&res); return res;  }
	void SetAbsScale(in Vector v) { C4DOS.Bo.SetAbsScale(&this, v); }
	void SetAbsScale(ref const  Vector v) { C4DOS.Bo.SetAbsScale(&this, v); }

	Vector GetAbsRot() const { Vector res=void; C4DOS.Bo.GetAbsRot(&this,&res); return res; }
	void SetAbsRot(in Vector v) { C4DOS.Bo.SetAbsRot(&this, v); }
	void SetAbsRot(ref const  Vector v) { C4DOS.Bo.SetAbsRot(&this, v); }

	Vector GetFrozenPos() const { Vector res=void; C4DOS.Bo.GetFrozenPos(&this,&res); return res; }
	void SetFrozenPos(in Vector v) { C4DOS.Bo.SetFrozenPos(&this, v); }
	void SetFrozenPos(ref const Vector v) { C4DOS.Bo.SetFrozenPos(&this, v); }

	Vector GetFrozenScale() const { Vector res=void; C4DOS.Bo.GetFrozenScale(&this,&res); return res; }
	void SetFrozenScale(in Vector v) { C4DOS.Bo.SetFrozenScale(&this, v); }
	void SetFrozenScale(ref const Vector v) { C4DOS.Bo.SetFrozenScale(&this, v); }

	Vector GetFrozenRot() const { Vector res=void; C4DOS.Bo.GetFrozenRot(&this,&res); return res; }
	void SetFrozenRot(in Vector v) { C4DOS.Bo.SetFrozenRot(&this, v); }
	void SetFrozenRot(ref const Vector v) { C4DOS.Bo.SetFrozenRot(&this, v); }

	Vector GetRelPos() const { Vector res=void; C4DOS.Bo.GetRelPos(&this,&res); return res; }
	void SetRelPos(in Vector v) { C4DOS.Bo.SetRelPos(&this, v); }
	void SetRelPos(ref const Vector v) { C4DOS.Bo.SetRelPos(&this, v); }

	Vector GetRelScale() const { Vector res=void; C4DOS.Bo.GetRelScale(&this,&res); return res; }
	void SetRelScale(in Vector v) { C4DOS.Bo.SetRelScale(&this, v); }
	void SetRelScale(ref const Vector v) { C4DOS.Bo.SetRelScale(&this, v); }

	Vector GetRelRot() const { Vector res=void; C4DOS.Bo.GetRelRot(&this,&res); return res; }
	void SetRelRot(in Vector v) { C4DOS.Bo.SetRelRot(&this, v); }
	void SetRelRot(ref const Vector v) { C4DOS.Bo.SetRelRot(&this, v); }

	ref Matrix GetMl() const { return C4DOS.Bo.GetMl(&this, ); }
	void SetMl(ref const Matrix m) { C4DOS.Bo.SetMl(&this, m); }

	Matrix GetFrozenMln() const { Matrix res=void; C4DOS.Bo.GetFrozenMln(&this,&res ); return res;  }

	Matrix GetRelMln() const { Matrix res=void;  C4DOS.Bo.GetRelMln(&this,&res); return res;  }
	Matrix GetRelMl() const { Matrix res=void;  C4DOS.Bo.GetRelMl(&this,&res); return res;  }
	void SetRelMl(ref const Matrix m) { C4DOS.Bo.SetRelMl(&this, m); }

	Matrix GetMg() const { Matrix res=void;  C4DOS.Bo.GetMg(&this,&res); return res;  }
	void SetMg(ref const Matrix m) { C4DOS.Bo.SetMg(&this, m); }

	Matrix GetMln() const { Matrix res=void;  C4DOS.Bo.GetMln(&this,&res); return res;  }
	Matrix GetMgn() const { Matrix res=void;  C4DOS.Bo.GetMgn(&this,&res); return res;  }
	Matrix GetUpMg() const { Matrix res=void;  C4DOS.Bo.GetUpMg(&this,&res); return res;  }

	void CopyMatrixTo(BaseObject* dst) { C4DOS.Bo.CopyMatrixTo(&this, dst); }

	Vector GetMp () { return C4DOS.Bo.GetMp(&this); }
	Vector GetRad() { return C4DOS.Bo.GetRad(&this); }

	Int32 GetEditorMode();
	void SetEditorMode(Int32 mode);

	Int32 GetRenderMode();
	void SetRenderMode(Int32 mode);

	Bool GetDeformMode();
	void SetDeformMode(Bool mode);

	Int32 GetUniqueIP();
	void SetUniqueIP(Int32 ip);

	void SetOrigin(BaseObject* origin);
	BaseObject* GetOrigin(Bool safe);
	BaseObject* GetTopOrigin(Bool parent, Bool safe);
	BaseObject* GetEditObject(BaseObject** psds, DISPLAYEDITSTATE state);

	BaseTag* GetFirstTag();
	BaseTag* GetTag(Int32 type, Int32 nr = 0) { return C4DOS.Bo.GetTag(&this, type, nr); }
	void* GetTagDataR(Int32 type, Int32 nr = 0) const { return C4DOS.Bo.GetTagDataR(&this, type, nr); }
	void* GetTagDataW(Int32 type, Int32 nr = 0) { return C4DOS.Bo.GetTagData(&this, type, nr); }
	Int32	GetTagDataCount(Int32 type) const { return C4DOS.Bo.GetTagDataCount(&this, type); }
	BaseTag* MakeTag (Int32 type, BaseTag* pred = nullptr);
	VariableTag* MakeVariableTag(Int32 type, Int32 count, BaseTag* pred = nullptr);
	void InsertTag(BaseTag* tp, BaseTag* pred = nullptr);
	void KillTag (Int32 type, Int32 nr = 0);

	BaseObject* GetCache(HierarchyHelp* hh = nullptr) { return C4DOS.Bo.GetCache(&this, hh); }
	BaseObject* GetDeformCache() { return C4DOS.Bo.GetDeformCache(&this); }
	LineObject* GetIsoparm() { return C4DOS.Bo.GetIsoparm(&this); }
	void SetIsoparm(LineObject* l);
	BaseObject* GetCacheParent();

	Bool CopyTagsTo(BaseObject* dest, Int32 visible, Int32 variable, Int32 hierarchical, AliasTrans* trans);

	Bool SetPhong(Bool on, Bool anglelimit, Float angle);

	Bool IsDirty(DIRTYFLAGS flags)  { return C4DOS.Bo.IsDirty(&this, flags); }
	void SetDirty(DIRTYFLAGS flags) { C4DOS.Bo.SetDirty(cast(C4DAtom*)&this, flags); }
	Bool CheckCache(HierarchyHelp* hh) { return C4DOS.Bo.CheckCache(&this, hh); }
	void Touch();

	void SetColorProperties(ObjectColorProperties* prop);
	void GetColorProperties(ObjectColorProperties* prop);

	SplineObject* GetRealSpline();

	Int32	GetHighlightHandle(BaseDraw* bd) { return C4DOS.Bo.GetHighlightHandle(&this, bd); }

	static BaseObject* Alloc(Int32 type);
	static void Free(ref BaseObject* bl);

	ref const Matrix  GetModelingAxis(BaseDocument* doc) { return C4DOS.Bo.GetModelingAxis(&this, doc); }
	void SetModelingAxis(ref const Matrix  m) { C4DOS.Bo.SetModelingAxis(&this, m); }

	BaseObject* GetAndCheckHierarchyClone(HierarchyHelp* hh, BaseObject* op, HIERARCHYCLONEFLAGS flags, Bool* dirty, AliasTrans* trans, Bool allchildren);
	BaseObject* GetHierarchyClone(HierarchyHelp* hh, BaseObject* op, HIERARCHYCLONEFLAGS flags, Bool* dirty, AliasTrans* trans);

	void NewDependenceList();
	Bool CompareDependenceList();
	void AddDependence(HierarchyHelp* hh, BaseObject* op);
	void TouchDependenceList();

	void RemoveFromCache();

	Bool SearchHierarchy(BaseObject* op) { return C4DOS.Bo.SearchHierarchy(&this, op); }

	void SetRotationOrder(ROTATIONORDER order)  { C4DOS.Bo.SetRotationOrder(&this, order); }
	ROTATIONORDER GetRotationOrder() const { return C4DOS.Bo.GetRotationOrder(&this ); }

	UInt64 GetGUID() { return C4DOS.Bo.GetGUID(&this); }
	
};


/+
/////////////////////////////////////////////////////////////
// CINEMA 4D SDK                                           //
/////////////////////////////////////////////////////////////
// (c) MAXON Computer GmbH, all rights reserved            //
/////////////////////////////////////////////////////////////

#ifndef __C4DBASEOBJECT_H
#define __C4DBASEOBJECT_H

#ifdef __API_INTERN__
abc def xyz
#endif

#include "c4d_baselist.h"
#include "c4d_basecontainer.h"
#include "operatingsystem.h"

class BaseTag;
class BaseDocument;
class BaseContainer;
class LineObject;
class BaseThread;
class BaseSelect;
class Neighbor;

#define MODE_ON		 0
#define MODE_OFF	 1
#define MODE_UNDEF 2

struct CPolygon
{
	Int32 a, b, c, d;

public:
	CPolygon() { }
	CPolygon(Int32 t_a, Int32 t_b, Int32 t_c) { a = t_a; b = t_b; c = d = t_c; }
	CPolygon(Int32 t_a, Int32 t_b, Int32 t_c, Int32 t_d) { a = t_a; b = t_b; c = t_c; d = t_d; }

	Int32& operator[](Int32 index) const { return ((Int32*)this)[index & 3]; }
	Bool	IsTriangle() const { return c == d; }
	Int32 Find(Int32 index) const { return (d == index ? 3 : (c == index ? 2 : (b == index ? 1 : (a == index ? 0 : NOTOK)))); }
	Int32 FindEdge(Int32 index1, Int32 index2) const
	{
		if (d == index1)
			return a == index2 ? 3 : (c == d ? (b == index2 ? 1 : NOTOK) : (c == index2 ? 2 : NOTOK));
		if (c == index1)
			return b == index2 ? 1 : (c == d ? (a == index2 ? 3 : NOTOK) : (d == index2 ? 2 : NOTOK));
		if (b == index1)
			return c == index2 ? 1 : (a == index2 ? 0 : NOTOK);
		if (a == index1)
			return b == index2 ? 0 : (d == index2 ? 3 : NOTOK);
		return NOTOK;
	}
	void EdgePoints(Int32 edge, Int32& a, Int32& b) const
	{
		a = ((Int32*)this)[edge & 3];
		b = ((Int32*)this)[(edge + 1) & 3];
	}
	Int32& GetPoint(Int32 index) const
	{
		if (c == d)
			return ((Int32*)this)[(index + (3 << 24)) % 3];
		return ((Int32*)this)[index & 3];
	}
};

struct Tangent
{
	Vector vl, vr;
};

struct Segment
{
	Int32	cnt;
	Bool	closed;
};

struct ObjectColorProperties
{
	Int32	 usecolor;
	Vector color;
	Bool	 xray;
};

class HierarchyHelp
{
private:
	HierarchyHelp();
	~HierarchyHelp();

public:
	Float GetLOD() { return C4DOS.Bd.HhGetLOD(this); }
	BUILDFLAGS GetBuildFlags() { return C4DOS.Bd.HhGetBuildFlags(this); }
	const Matrix& GetMg() { return C4DOS.Bd.HhGetMg(this); }
	BaseThread* GetThread() { return C4DOS.Bd.HhGetThread(this); }
	BaseDocument* GetDocument() { return C4DOS.Bd.HhGetDocument(this); }
};

class BaseObject : public BaseList2D
{
private:
	BaseObject();
	~BaseObject();

public:
	BaseObject* GetNext    () { return (BaseObject*)AtCall(GetNext) (); }
	BaseObject* GetPred    () { return (BaseObject*)AtCall(GetPred) (); }
	BaseObject* GetUp      () { return (BaseObject*)AtCall(GetUp) (); }
	BaseObject* GetDown    () { return (BaseObject*)AtCall(GetDown) (); }
	BaseObject* GetDownLast() { return (BaseObject*)AtCall(GetDownLast) (); }

	Float GetVisibility(Float parent);

	Vector GetAbsPos() const { return BoCall(GetAbsPos) (cast); }
	void SetAbsPos(const Vector& v) { BoCall(SetAbsPos) (v); }

	Vector GetAbsScale() const { return BoCall(GetAbsScale) (); }
	void SetAbsScale(const Vector& v) { BoCall(SetAbsScale) (v); }

	Vector GetAbsRot() const { return BoCall(GetAbsRot) (); }
	void SetAbsRot(const Vector& v) { BoCall(SetAbsRot) (v); }

	Vector GetFrozenPos() const { return BoCall(GetFrozenPos) (); }
	void SetFrozenPos(const Vector& v) { BoCall(SetFrozenPos) (v); }

	Vector GetFrozenScale() const { return BoCall(GetFrozenScale) (); }
	void SetFrozenScale(const Vector& v) { BoCall(SetFrozenScale) (v); }

	Vector GetFrozenRot() const { return BoCall(GetFrozenRot) (); }
	void SetFrozenRot(const Vector& v) { BoCall(SetFrozenRot) (v); }

	Vector GetRelPos() const { return BoCall(GetRelPos) (); }
	void SetRelPos(const Vector& v) { BoCall(SetRelPos) (v); }

	Vector GetRelScale() const { return BoCall(GetRelScale) (); }
	void SetRelScale(const Vector& v) { BoCall(SetRelScale) (v); }

	Vector GetRelRot() const { return BoCall(GetRelRot) (); }
	void SetRelRot(const Vector& v) { BoCall(SetRelRot) (v); }

	const Matrix& GetMl() const { return BoCall(GetMl) (); }
	void SetMl(const Matrix& m) { BoCall(SetMl) (m); }

	Matrix GetFrozenMln() const { return BoCall(GetFrozenMln) (); }

	Matrix GetRelMln() const { return BoCall(GetRelMln) (); }
	Matrix GetRelMl() const { return BoCall(GetRelMl) (); }
	void SetRelMl(const Matrix& m) { BoCall(SetRelMl) (m); }

	Matrix GetMg() const { return BoCall(GetMg) (); }
	void SetMg(const Matrix& m) { BoCall(SetMg) (m); }

	Matrix GetMln() const { return BoCall(GetMln) (); }
	Matrix GetMgn() const { return BoCall(GetMgn) (); }
	Matrix GetUpMg() const { return BoCall(GetUpMg) (); }

	void CopyMatrixTo(BaseObject* dst) { C4DOS.Bo.CopyMatrixTo(this, dst); }

	Vector GetMp () { return C4DOS.Bo.GetMp(this); }
	Vector GetRad() { return C4DOS.Bo.GetRad(this); }

	Int32 GetEditorMode();
	void SetEditorMode(Int32 mode);

	Int32 GetRenderMode();
	void SetRenderMode(Int32 mode);

	Bool GetDeformMode();
	void SetDeformMode(Bool mode);

	Int32 GetUniqueIP();
	void SetUniqueIP(Int32 ip);

	void SetOrigin(BaseObject* origin);
	BaseObject* GetOrigin(Bool safe);
	BaseObject* GetTopOrigin(Bool parent, Bool safe);
	BaseObject* GetEditObject(BaseObject** psds, DISPLAYEDITSTATE state);

	BaseTag* GetFirstTag();
	BaseTag* GetTag(Int32 type, Int32 nr = 0) { return C4DOS.Bo.GetTag(this, type, nr); }
	const void* GetTagDataR(Int32 type, Int32 nr = 0) const { return C4DOS.Bo.GetTagDataR(this, type, nr); }
	void* GetTagDataW(Int32 type, Int32 nr = 0) { return C4DOS.Bo.GetTagData(this, type, nr); }
	Int32	GetTagDataCount(Int32 type) const { return C4DOS.Bo.GetTagDataCount(this, type); }
	BaseTag* MakeTag (Int32 type, BaseTag* pred = nullptr);
	VariableTag* MakeVariableTag(Int32 type, Int32 count, BaseTag* pred = nullptr);
	void InsertTag(BaseTag* tp, BaseTag* pred = nullptr);
	void KillTag (Int32 type, Int32 nr = 0);

	BaseObject* GetCache(HierarchyHelp* hh = nullptr) { return C4DOS.Bo.GetCache(this, hh); }
	BaseObject* GetDeformCache() { return C4DOS.Bo.GetDeformCache(this); }
	LineObject* GetIsoparm() { return C4DOS.Bo.GetIsoparm(this); }
	void SetIsoparm(LineObject* l);
	BaseObject* GetCacheParent();

	Bool CopyTagsTo(BaseObject* dest, Int32 visible, Int32 variable, Int32 hierarchical, AliasTrans* trans);

	Bool SetPhong(Bool on, Bool anglelimit, Float angle);

	Bool IsDirty(DIRTYFLAGS flags)  { return C4DOS.Bo.IsDirty(this, flags); }
	void SetDirty(DIRTYFLAGS flags) { C4DOS.Bo.SetDirty(this, flags); }
	Bool CheckCache(HierarchyHelp* hh) { return C4DOS.Bo.CheckCache(this, hh); }
	void Touch();

	void SetColorProperties(ObjectColorProperties* prop);
	void GetColorProperties(ObjectColorProperties* prop);

	SplineObject* GetRealSpline();

	Int32	GetHighlightHandle(BaseDraw* bd) { return C4DOS.Bo.GetHighlightHandle(this, bd); }

	static BaseObject* Alloc(Int32 type);
	static void Free(BaseObject*& bl);

	const Matrix& GetModelingAxis(BaseDocument* doc) { return C4DOS.Bo.GetModelingAxis(this, doc); }
	void SetModelingAxis(const Matrix& m) { C4DOS.Bo.SetModelingAxis(this, m); }

	BaseObject* GetAndCheckHierarchyClone(HierarchyHelp* hh, BaseObject* op, HIERARCHYCLONEFLAGS flags, Bool* dirty, AliasTrans* trans, Bool allchildren);
	BaseObject* GetHierarchyClone(HierarchyHelp* hh, BaseObject* op, HIERARCHYCLONEFLAGS flags, Bool* dirty, AliasTrans* trans);

	void NewDependenceList();
	Bool CompareDependenceList();
	void AddDependence(HierarchyHelp* hh, BaseObject* op);
	void TouchDependenceList();

	void RemoveFromCache();

	Bool SearchHierarchy(BaseObject* op) { return C4DOS.Bo.SearchHierarchy(this, op); }

	void SetRotationOrder(ROTATIONORDER order)  { BoCall(SetRotationOrder) (order); }
	ROTATIONORDER GetRotationOrder() const { return BoCall(GetRotationOrder) (); }

	UInt64 GetGUID() { return C4DOS.Bo.GetGUID(this); }
};

class CameraObject : public BaseObject
{
private:
	CameraObject();
	~CameraObject();

public:
	Int32	GetProjection();
	Float	GetFocus();
	Float	GetZoom();
	Vector GetOffset();
	Float	GetAperture();
	Bool SetProjection(Int32 projection);
	Bool SetFocus(Float v);
	Bool SetAperture(Float v);
	Bool SetZoom(Float zoom);
	Bool SetOffset(const Vector& offset);

	Int32	StereoGetCameraCount(BaseDocument* doc, BaseDraw* bd, RenderData* rd, Int32 flags) const;
	Bool StereoGetCameraInfo(BaseDocument* doc, BaseDraw* bd, RenderData* rd, Int32 n, StereoCameraInfo& info, Int32 flags) const;

	static CameraObject* Alloc();
	static void Free(CameraObject*& bl);
};

class PointObject : public BaseObject
{
private:
	PointObject();
	~PointObject();

public:
	BaseSelect* GetPointS();
	BaseSelect* GetPointH();

	const Vector* GetPointR() const { return (const Vector*)GetTagDataR(Tpoint); }
	Vector* GetPointW() { return (Vector*)GetTagDataW(Tpoint); }
	Int32	GetPointCount() const { return GetTagDataCount(Tpoint); }

	Float32* CalcVertexMap(BaseObject* modifier);

	Bool ResizeObject(Int32 pcnt);
	void IncreaseBoundingBox(Int32 cnt, Vector* v);	// increases the bounding box of the object without making the object dirty
};

struct CLine
{
	Float t, pos;
};

class LineObject : public PointObject
{
private:
	LineObject();
	~LineObject();

public:
	const Segment* GetSegmentR()		{ return (const Segment*)GetTagDataR(Tsegment); }
	Segment* GetSegmentW()	{ return (Segment*)GetTagDataW(Tsegment); }
	Int32	GetSegmentCount() { return GetTagDataCount(Tsegment); }

	const CLine* GetLineR()  { return (const CLine*)GetTagDataR(Tline); }
	CLine* GetLineW() { return (CLine*)GetTagDataW(Tline); }

	Bool ResizeObject(Int32 pcnt, Int32 scnt);
	PolygonObject* Triangulate(Float regular, BaseThread* bt);

	static LineObject* Alloc(Int32 pcnt, Int32 scnt);
	static void Free(LineObject*& bl);
};

#define POLYOBJECT_VBO_VERTEX					 0x00000001
#define POLYOBJECT_VBO_PHONG_NORMAL		 0x00000002
#define POLYOBJECT_VBO_POLYGON_NORMAL	 0x00000004
#define POLYOBJECT_VBO_DISPLACE_NORMAL 0x00000008
#define POLYOBJECT_VBO_STICK_TEXTURE	 0x00000010
#define POLYOBJECT_VBO_COLOR					 0x00000020

class PolygonObject : public PointObject
{
private:
	PolygonObject();
	~PolygonObject();

public:
	BaseSelect* GetPolygonS();
	BaseSelect* GetPolygonH();

	BaseSelect* GetEdgeS();
	BaseSelect* GetEdgeH();

	BaseSelect* GetPhongBreak();

	const CPolygon* GetPolygonR()  { return (const CPolygon*)GetTagDataR(Tpolygon); }
	CPolygon* GetPolygonW() { return (CPolygon*)GetTagDataW(Tpolygon); }
	Int32	GetPolygonCount() { return GetTagDataCount(Tpolygon); }

	Bool ResizeObject(Int32 pcnt, Int32 vcnt);
	Bool ResizeObject(Int32 pcnt, Int32 vcnt, Int32 ncnt);
	Bool ResizeObject(Int32 pcnt, Int32 vcnt, Int32 ncnt, Int32 vc_flags);

	BaseSelect* GetSelectedEdges(Neighbor* e, EDGESELECTIONTYPE ltype);
	BaseSelect* GetSelectedEdges(Neighbor* e, BaseSelect* sel);
	Bool SetSelectedEdges(Neighbor* e, BaseSelect* pSel, EDGESELECTIONTYPE ltype);
	Vector32* CreatePhongNormals();
	Bool GetPolygonTranslationMap(Int32& ngoncnt, Int32*& polymap);							// polygon index . ngon index
	Bool GetNGonTranslationMap(Int32 ngoncnt, Int32* polymap, Int32**& ngons);	// ngon index . polygons
	Pgon* GetAndBuildNgon();
	Int32 GetNgonCount();
	void GetSelectedNgons(BaseSelect* sel);
	void GetHiddenNgons(BaseSelect* sel);
	NgonBase* GetNgonBase();
	Bool ValidateEdgeSelection(BaseSelect* sel);
	Bool ValidateEdgeSelection();
	Bool GetEdgeSelection(BaseSelect* sel, EDGESELECTIONTYPE type);
	void GetNgonEdgesCompact(UChar*& edges);

	UInt32 VBOInitUpdate(BaseDraw* bd);
	Bool VBOStartUpdate(BaseDraw* bd, GlVertexBufferAccessFlags access, Bool latemap);
	const GlVertexBufferAttributeInfo* VBOUpdateVectorGetAttribute(UInt32 flags);
	void VBOUpdateVector(Int32 i, const Vector32& v, const GlVertexBufferAttributeInfo* pInfo) { C4DOS.Bo.PyVBOUpdateVector(this, i, v, pInfo); }
	void VBOUpdateFaceVector(Int32 i, const Vector32& v, const GlVertexBufferAttributeInfo* pInfo) { C4DOS.Bo.PyVBOUpdateFaceVector(this, i, v, pInfo); }
	void VBOInvalidate() { C4DOS.Bo.PyVBOInvalidate(this); }

	void VBOEndUpdate(BaseDraw* bd);
	void VBOFreeUpdate();

	static PolygonObject* Alloc(Int32 pcnt, Int32 vcnt);
	static void Free(PolygonObject*& bl);
};

class SplineLengthData
{
private:
	SplineLengthData();
	~SplineLengthData();

public:
	Bool Init(SplineObject* op, Int32 segment = 0, const Vector* padr = nullptr);

	Float UniformToNatural(Float t);
	Float GetLength();
	Float GetSegmentLength(Int32 a, Int32 b);

	static SplineLengthData* Alloc();
	static void Free(SplineLengthData*& bl);
};

class SplineObject : public PointObject
{
private:
	SplineObject();
	~SplineObject();

public:
	SPLINETYPE GetInterpolationType() const;
	Bool IsClosed();
	Vector GetSplinePoint  (Float t, Int32 segment = 0, const Vector* padr = nullptr);
	Vector GetSplineTangent(Float t, Int32 segment = 0, const Vector* padr = nullptr);
	Bool SetDefaultCoeff();
	Bool ResizeObject(Int32 pcnt, Int32 scnt);

	const Segment* GetSegmentR()  { return (const Segment*)GetTagDataR(Tsegment); }
	Segment* GetSegmentW() { return (Segment*)GetTagDataW(Tsegment); }
	Int32	GetSegmentCount() { return GetTagDataCount(Tsegment); }

	const Tangent* GetTangentR()  {	return (Tangent*)GetTagDataR(Ttangent); }
	Tangent* GetTangentW() { return (Tangent*)GetTagDataW(Ttangent); }
	Int32	GetTangentCount() {	return GetTagDataCount(Ttangent); }

	LineObject* GetLineObject(BaseDocument* doc, Float lod, BaseThread* thread = nullptr);

	static SplineObject* Alloc(Int32 pcnt, SPLINETYPE type);
	static void Free(SplineObject*& bl);
};

BaseObject* GeneratePrimitive(BaseDocument* doc, Int32 type, const BaseContainer& bc, Float lod, Bool isoparm, BaseThread* bt = nullptr);
BaseObject* GenerateSplinePrimitive(BaseDocument* doc, Int32 type, const BaseContainer& bc, Float lod, BaseThread* bt = nullptr);

#define ToPoint(op)	 ((PointObject*)(op))
#define ToPoly(op)	 ((PolygonObject*)(op))
#define ToSpline(op) ((SplineObject*)(op))

inline Vector CalcFaceNormal(const Vector* padr, const CPolygon& v)
{
	if (v.c == v.d)
		return !Cross((padr[v.b] - padr[v.a]), (padr[v.c] - padr[v.a]));
	else
		return !Cross((padr[v.b] - padr[v.d]), (padr[v.c] - padr[v.a]));
}

class Safety
{
private:
	ObjectSafety* os;

public:
	Safety();
	~Safety();
	Bool Init(BaseObject* op);
	void Detach();
};

Int32 CalcLOD(Int32 val, Float lod, Int32 min, Int32 max);
Bool DisjointMesh(PointObject* op);

SplineObject* FitCurve(Vector* padr, Int32 pcnt, Float error, BaseThread* bt);
Bool Triangulate(const Vector* padr, Int32 pcnt, CPolygon** vadr, Int32* vcnt);
Bool TriangulateStandard(const Vector* padr, Int32 pcnt, Int32* list, Int32 lcnt, CPolygon*& vadr, Int32& vcnt, BaseThread* thread);
Bool TriangulateRegular(const Vector* pinp, Int32 pinp_cnt, Int32* list, Int32 lcnt, Vector*& padr, Int32& pcnt, CPolygon*& vadr, Int32& vcnt, Float regular_width, BaseThread* thread);
BaseObject* GenerateText(BaseContainer* cp, BaseThread* bt, Bool separate);
Bool CheckDisplayFilter(BaseObject* op, Int32 filter);
Int32 IntersectionTest(PolygonObject* op, BaseDraw* bd, Float x, Float y, const Matrix& mg, Float* z, MODELINGCOMMANDMODE mode, UChar* pPointSelect, Int32 lSelectCount);

struct PolyInfo
{
	Int32 face[4];
	Int32 edge[4];
	Char	mark[4];
};

struct NgonNeighbor
{
	struct NgonNeighborSegment
	{
		Int32	 ptcnt;									// number of points in this segment
		Int32* pts;										// points
		Int32* edges;									// edges
		Int32* nbr;										// neighbor polygons
	};
	Int32								 segcnt;		// number of segments (always >= 1)
	NgonNeighborSegment* segments;	// always != nullptr
};

class Neighbor
{
private:
	EnumerateEdges* ee;

public:
	Neighbor();
	virtual ~Neighbor();

	virtual Bool Init(Int32 pcnt, const CPolygon* vadr, Int32 vcnt, BaseSelect* bs);
	void GetEdgePolys(Int32 a, Int32 b, Int32* first, Int32* second) { C4DOS.Nb.GetEdgePolys(ee, a, b, first, second); }
	void GetPointPolys(Int32 pnt, Int32** dadr, Int32* dcnt)  { C4DOS.Nb.GetPointPolys(ee, pnt, dadr, dcnt); }
	Int32 GetEdgeCount();
	PolyInfo* GetPolyInfo(Int32 poly) { return C4DOS.Nb.GetPolyInfo(ee, poly); }
	Int32 GetNeighbor(Int32 a, Int32 b, Int32 poly);
	Bool GetNGons(PolygonObject* op, Int32& ngoncnt, NgonNeighbor*& ngons) { return C4DOS.Nb.GetNGons(ee, op, ngoncnt, ngons); }
	void Flush() { C4DOS.Nb.Free(ee); ee = nullptr; }
	void ResetAddress(const CPolygon* a_polyadr) { C4DOS.Nb.ResetAddress(ee, a_polyadr); }
};

BaseObject* GetVirtualLineObject(BaseObject* op, HierarchyHelp* hh, const Matrix& mloc, Bool keep_spline, Bool recurse, Matrix* mres, Bool* dirty);

UVWTag* GenerateUVW(BaseObject* op, const Matrix& opmg, TextureTag* tp, const Matrix& texopmg, BaseView* view);

// special handling: light object
void CutReal(BaseContainer& data, Int32 id, Float min, Float max);
void CutVector(BaseContainer& data, Int32 id, Float min, Float max);
Bool CalculateVisiblePoints(BaseDraw* bd, PolygonObject* op, Vector* padr, UChar* pset, Bool select_visibonly);

// for triangulating
#define POLY_TRIANG_CONSTRAINED_OUTLINE 1													// all points form the outline, the segments are ignored
#define POLY_TRIANG_QUADS								8													// untriangulate where possible
#define POLY_TRIANG_NGON								32												// must be set if an ngon is to be triangulated.
#define POLY_TRIANG_FORCE_VORONOI				64												// force Voronoi triangulation
#define POLY_TRIANG_FORCE_NGON					(128 | POLY_TRIANG_NGON)	// force special ngon triangulation
#define POLY_TRIANG_FILL_HOLES					256												// fill segment holes (only used for ngon triangulation)

#define TRIANGSTATE_SKIP_EDGE					 1
#define TRIANGSTATE_MISSING_CONSTRAINT 2

class PolyTriangulate
{
private:
	PolyTriangulate();
	~PolyTriangulate();

public:
	static PolyTriangulate* Alloc();
	static void Free(PolyTriangulate*& pTriang);

	// Don't store pPolys for later use. It will get invalid after the next Triangulate call
	// or when this class instance is destroyed.
	// Use TriangulateRelease if you need to store the result for a later use.

	// lConstraints and plConstrainedEdges are reserved for later use
	Bool Triangulate(const Vector* pvPoints, Int32 lPointCount, const Int32* plSegments, Int32 lSegCnt,
									 CPolygon*& pPolys, Int32& lPolyCount, Int32 lFlags = 0, const Int32* plMap = nullptr, BaseThread* pThread = nullptr,
									 Int32 lConstraints = 0, const Int32* plConstrainedEdges = nullptr);
	// You must call DeleteMem(pPolys) to free memory
	Bool TriangulateRelease(const Vector* pvPoints, Int32 lPointCount, const Int32* plSegments, Int32 lSegCnt,
													CPolygon*& pPolys, Int32& lPolyCount, Int32 lFlags = 0, const Int32* plMap = nullptr, BaseThread* pThread = nullptr,
													Int32 lConstraints = 0, const Int32* plConstrainedEdges = nullptr);

#ifdef __FLOAT_32_BIT
	Bool Triangulate(const Vector64* pvPoints, Int32 lPointCount, const Int32* plSegments, Int32 lSegCnt,
									 CPolygon*& pPolys, Int32& lPolyCount, Int32 lFlags = 0, const Int32* plMap = nullptr, BaseThread* pThread = nullptr,
									 Int32 lConstraints = 0, const Int32* plConstrainedEdges = nullptr);

	Bool TriangulateRelease(const Vector64* pvPoints, Int32 lPointCount, const Int32* plSegments, Int32 lSegCnt,
													CPolygon*& pPolys, Int32& lPolyCount, Int32 lFlags = 0, const Int32* plMap = nullptr, BaseThread* pThread = nullptr,
													Int32 lConstraints = 0, const Int32* plConstrainedEdges = nullptr);
#endif

	Bool HasIdentical();
	void SetPolygonMatrix(Matrix64* m);
	UInt32 GetState();
};

#endif


+/