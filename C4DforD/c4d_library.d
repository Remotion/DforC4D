
module c4d_library;

public import c4d_general;

//#define LIBOFFSET(s, m) (Int32)((UInt)(&(((s*)0)->m)))

//auto LIBOFFSET(  ARG1,  ARG2 )(ARG1 s, ARG2 m) { return cast(Int32)(cast(UInt)(&((cast(s*)0).m))); }
/*auto LIBOFFSET(  ARG1,alias ARG2 )(ARG1 s) { 
	return cast(Int32)(
					   cast(UInt)(
								  &( 
									(cast(s*)0).ARG2
									)
								  )
					   );
}*/

/*auto LIBOFFSET( alias ARG1, alias ARG2 )(){
	return ARG1.ARG2.offsetof;
}*/

//regex:
/// LIBOFFSET\((\w+),\s*(\w+)\)
/// LIBOFFSET!($1.$2)

template LIBOFFSET( alias T ){
	enum LIBOFFSET = T.offsetof;
}

template LIBOFFSET( alias S, alias F ){
	enum LIBOFFSET = S.F.offsetof;
}

extern(C++) //! important 
struct C4DLibrary
{
	Int32	lib_version;
	Int32	size;
};

//Bool InstallLibrary(Int32 id, C4DLibrary* lib, Int32 version, Int32 size);
//Bool UninstallLibrary(C4DLibrary* lib, Int32 version, Int32 size);
//C4DLibrary* CheckLib(Int32 id, Int offset, C4DLibrary** store);
//Bool IsLibraryInstalled(Int32 id);


Bool InstallLibrary(Int32 id, C4DLibrary* lib, Int32 lib_version, Int32 size)
{
	lib.lib_version = lib_version;
	lib.size = size;
	return GeRegistryAdd(id, REGISTRYTYPE_LIBRARY, lib);
}

Bool UninstallLibrary(C4DLibrary* lib, Int32 lib_version, Int32 size)
{
	return true;
}

Bool IsLibraryInstalled(Int32 id)
{
	Registry* reg = GeRegistryFind(id, REGISTRYTYPE_LIBRARY);
	if (!reg) return false;
	C4DLibrary* lib = cast(C4DLibrary*)reg.GetData();
	return lib != null;
}

//extern(C++)
C4DLibrary* CheckLib(Int32 id, Int offset, C4DLibrary** store)
{
	//printf(" CheckLib %i %i  %p,%p \n",id,offset,store,*store);
	if (store && *store) return *store;
	Registry* reg = GeRegistryFind(id, REGISTRYTYPE_LIBRARY);
	if (!reg)	return null;
	//printf(" Registry %p \n",reg);
	C4DLibrary* lib = cast(C4DLibrary*)reg.GetData();
	if (!lib) return null;
	//printf(" C4DLibrary %p \n",lib);
	if (store)	*store = lib;
	// not the right version
	if (offset > lib.size)	return null;
	//printf(" offset %i %i \n",lib.lib_version,lib.size);
	return lib;
}




