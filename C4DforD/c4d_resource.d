
module c4d_resource;

import c4d;
import c4d_os;

import c4d_file;

//=============================================================================
struct GeResource
{
private:
	LocalResource * lr = null;
	Bool			state = false, glob = false;
	Filename*		initfn = null;
	Bool			_regardIsStopped = false;

public:
	//static GeResource opCall();
	~this(){ Free(); }

	Bool Init(){ return Init(GeGetPluginPath()); }
	Bool Init()(auto ref const Filename path, Bool regardIsStopped = true){
		_regardIsStopped = regardIsStopped;
		if (!initfn) {
			//? initfn = NewObjClear(Filename, path); //? NewObjClear
			initfn = new Filename(path);
			if (!initfn)	return false;
		}
		if (state)	return lr != null;
		lr = C4DOS.Lr.Alloc(cast(Filename*)&path);
		state = true;
		return lr != null;
	}
	Bool InitAsGlobal()	{
		glob = true;
		lr = C4DOS.Lr.GetCinemaResource();
		return lr != null;
	}
	ref const String  LoadString(Int32 id)	{
		if (!lr)
			return *C4DOS.St.Default;
		return * C4DOS.Lr.LoadString(cast(LocalResource*)lr, id); //ref problem
	}
	Bool ReloadResource() {	// dangerous! don't use this in release code!!!
		if (glob) return true;
		if (!initfn) return false;
		return C4DOS.Lr.ReloadResource(lr, initfn);
	}
	void Free() {
		if (glob)	return;
		if (lr)	{
			C4DOS.Lr.Free(lr, _regardIsStopped);
			lr = null;
		}
		if (initfn) {
			//? DeleteObj(initfn); //? DeleteObj
			delete initfn;
		}
	}

	LocalResource* Get() { return lr; }
};


/*extern __gshared GeResource resource;

/*void FreeResource()
{
	resource.Free();
}*/
/*
ref const String  GeLoadString(Int32 id)
{
	return resource.LoadString(id);
}
*/

public import c4d_main : GeLoadString, FreeResource; //TODO:  move it here <<<<


String GeLoadString(Int32 id, ref const String  p1)
{
	Int32	 pos;
	String str = GeLoadString(id);//resource.LoadString(id);
	if (!str.FindFirst(String("#"), &pos))
		return String();
	str.Delete(pos, 1);
	str.Insert(pos, p1);
	return str;
}

String GeLoadString(Int32 id, ref const String  p1, ref const String  p2)
{
	Int32	 pos;
	String str = GeLoadString(id);//resource.LoadString(id);
	if (!str.FindFirst(String("#"), &pos))
		return String();
	str.Delete(pos, 1);
	str.Insert(pos, p1);
	if (!str.FindFirst(String("#"), &pos))
		return String();
	str.Delete(pos, 1);
	str.Insert(pos, p2);
	return str;
}

String GeLoadString(Int32 id, ref const String  p1, ref const String  p2, ref const String  p3)
{
	Int32	 pos;
	String str = GeLoadString(id);//resource.LoadString(id);
	if (!str.FindFirst(String("#"), &pos))
		return String();
	str.Delete(pos, 1);
	str.Insert(pos, p1);
	if (!str.FindFirst(String("#"), &pos))
		return String();
	str.Delete(pos, 1);
	str.Insert(pos, p2);
	if (!str.FindFirst(String("#"), &pos))
		return String();
	str.Delete(pos, 1);
	str.Insert(pos, p3);
	return str;
}

String GeLoadString(Int32 id, ref const String  p1, ref const String  p2, ref const String  p3, ref const String  p4)
{
	Int32	 pos;
	String str = GeLoadString(id);//resource.LoadString(id);
	if (!str.FindFirst(String("#"), &pos))
		return String();
	str.Delete(pos, 1);
	str.Insert(pos, p1);
	if (!str.FindFirst(String("#"), &pos))
		return String();
	str.Delete(pos, 1);
	str.Insert(pos, p2);
	if (!str.FindFirst(String("#"), &pos))
		return String();
	str.Delete(pos, 1);
	str.Insert(pos, p3);
	if (!str.FindFirst(String("#"), &pos))
		return String();
	str.Delete(pos, 1);
	str.Insert(pos, p4);
	return str;
}

BaseContainer* GetMenuResource(ref const String  menuname)
{
	return C4DOS.Lr.GetMenuResource(menuname);
}

void UpdateMenus()
{
	C4DOS.Lr.UpdateMenus();
}

Bool RegisterDescription(Int32 id, ref const String  idstr, LocalResource* res = null)
{
	//TODO >>>
	import lib_description : Description_Register;
	import c4d_main : resource;

	return Description_Register(id, idstr, res ? res : resource.Get());
}

/+
CUSTOMDATATYPEPLUGIN* FindCustomDataTypePlugin(Int32 type) {
	return C4DOS.Ge.FindCustomDataTypePlugin(type);
}

RESOURCEDATATYPEPLUGIN* FindResourceDataTypePlugin(Int32 type) {
	return C4DOS.Ge.FindResourceDataTypePlugin(type);
}

// #define CallResourceDataType(plug,fnc) (((ResourceDataTypeClass*)(plug->adr))->*plug->fnc)

BaseContainer GetCustomDataTypeDefault(Int32 type) {
	BaseContainer bc(type);
	RESOURCEDATATYPEPLUGIN* plug = FindResourceDataTypePlugin(type);
	if (plug) {
		//? CallResourceDataType(plug, GetDefaultProperties) (bc);

	}
	return bc;
}
+/

/+

const String& GeLoadString(Int32 id);
String GeLoadString(Int32 id, const String& p1);
String GeLoadString(Int32 id, const String& p1, const String& p2);
String GeLoadString(Int32 id, const String& p1, const String& p2, const String& p3);
String GeLoadString(Int32 id, const String& p1, const String& p2, const String& p3, const String& p4);

Bool RegisterDescription(Int32 id, const String& idstr, LocalResource* res = nullptr);

BaseContainer* GetMenuResource(const String& menuname);
Bool SearchMenuResource(BaseContainer* bc, const String& searchstr);
GeData* SearchPluginMenuResource(const String& identifier = String("IDS_EDITOR_PLUGINS"));
GeData* SearchPluginSubMenuResource(const String& identifier = String("IDS_EDITOR_PLUGINS"), BaseContainer* bc = nullptr);

void UpdateMenus(void);

extern GeResource resource;
void FreeResource();
+/
