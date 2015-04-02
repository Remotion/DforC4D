
module c4d_tools;

public import c4d_matrix;

enum COLOR =		255.99;	// converting from vectors to integers
enum PERCENT =		100.00;
enum THIRD =		0.333333333333333333;
enum SIXTH =		0.166666666666666666;

enum MAXRANGE =		1.0e20;		// maximum value for metric data
enum MAXELEMENTS =	100000000;	// maximum number of points
enum MIN_EPSILON =	0.001;		// epsilon value


Float64 StepEx(Float64 a, Float64 x) @safe pure nothrow
{
	if (x >= a)
		return 1.0;
	else
		return 0.0;
}

Float32 Boxstep(Float32 a, Float32 b, Float32 x) @safe pure nothrow
{
	if (b == a)
	{
		if (x < a)
			return cast(Float32) 0.0;
		else
			return cast(Float32) 1.0;
	}
	x = (x - a) / (b - a);
	return x < cast(Float32) 0.0 ? cast(Float32) 0.0 : (x > cast(Float32) 1.0 ? cast(Float32) 1.0 : x);
}

Float64 Boxstep(Float64 a, Float64 b, Float64 x) @safe pure nothrow
{
	if (b == a)
	{
		if (x < a)
			return 0.0;
		else
			return 1.0;
	}
	x = (x - a) / (b - a);
	return x < 0.0 ? 0.0 : (x > 1.0 ? 1.0 : x);
}

Float32 Smoothstep(Float32 a, Float32 b, Float32 x) @safe pure nothrow
{
	if (x < a)
		return cast(Float32) 0.0;
	if (x >= b)
		return cast(Float32) 1.0;

	x = (x - a) / (b - a);	// normalize to [0,1]

	return x * x * (cast(Float32) 3.0 - cast(Float32) 2.0 * x);
}

Float64 Smoothstep(Float64 a, Float64 b, Float64 x) @safe pure nothrow
{
	if (x < a)
		return 0.0;
	if (x >= b)
		return 1.0;

	x = (x - a) / (b - a);	// normalize to [0,1]

	return x * x * (3.0 - 2.0 * x);
}

Float32 Modulo(Float32 a, Float32 b) @safe pure nothrow
{
	if (b == 0.0)
		return 0.0;
	Int32 n = cast(Int32) (a / b);

	a -= n * b;
	if (a < 0.0)
		a += b;

	return a;
}

Float64 Modulo(Float64 a, Float64 b) @safe pure nothrow
{
	if (b == 0.0)
		return 0.0;
	Int32 n = cast(Int32) (a / b);

	a -= n * b;
	if (a < 0.0)
		a += b;

	return a;
}

Int32 LModulo(Int32 a, Int32 b) @safe pure nothrow
{
	if (!b)
		return 0;
	if (a >= 0)
		return a % b;

	a -= (a / b) * b;
	if (a < 0)
		a += b;

	return a;
}

Int64 LModulo(Int64 a, Int64 b) @safe pure nothrow
{
	if (!b)
		return 0;
	if (a >= 0)
		return a % b;

	a -= (a / b) * b;
	if (a < 0)
		a += b;

	return a;
}

Float32 Bias(Float32 b, Float32 x) @safe pure nothrow
{
	return Pow(x, (-Ln(b) / cast(Float32) 0.693147180559945309));
}

Float64 Bias(Float64 b, Float64 x) @safe pure nothrow
{
	return Pow(x, (-Ln(b) / 0.693147180559945309));
}

Float32 Truncate(Float32 x) @safe pure nothrow
{
	if (x >= cast(Float32) 0.0)
		return Floor(x);
	else
		return Ceil(x);
}

Float64 Truncate(Float64 x) @safe pure nothrow
{
	if (x >= 0.0)
		return Floor(x);
	else
		return Ceil(x);
}



Matrix MatrixMove(ref const Vector  t) @safe pure nothrow
{
	Matrix erg;
	erg.off = t;
	return erg;
}

Matrix MatrixScale(ref const Vector  s) @safe pure nothrow
{
	Matrix erg;

	erg.v1.x = s.x;
	erg.v2.y = s.y;
	erg.v3.z = s.z;
	return erg;
}

Matrix MatrixRotX(Float w) @safe pure nothrow
{
	Matrix erg;
	Float	 cs = Cos(w), sn = Sin(w);

	erg.v3.z = cs;
	erg.v2.z = -sn;
	erg.v3.y = sn;
	erg.v2.y = cs;
	return erg;
}

Matrix MatrixRotY(Float w) @safe pure nothrow
{
	Matrix erg;
	Float	 cs = Cos(w), sn = Sin(w);

	erg.v1.x = cs;
	erg.v3.x = -sn;
	erg.v1.z = sn;
	erg.v3.z = cs;
	return erg;
}

Matrix MatrixRotZ(Float w) @safe pure nothrow
{
	Matrix erg;
	Float	 cs = Cos(w), sn = Sin(w);

	erg.v1.x = cs;
	erg.v2.x = sn;
	erg.v1.y = -sn;
	erg.v2.y = cs;
	return erg;
}

Float GetNear(Float alt, Float* neu) @safe pure nothrow
{
	Float diff = (*neu - alt) / cast(Float) PI2;
	diff = (diff - Floor(diff)) * cast(Float) PI2;
	*neu = diff + alt;

	if (diff >= cast(Float) PI)
	{
		diff -= cast(Float) PI2;
		*neu -= cast(Float) PI2;
	}

	return diff;
}


// Winkel eines Punkts bestimmen
Vector VectorToHPB(ref const Vector p)
{
	Float	 l;
	Vector rot;
	l = Sqrt(p.x * p.x + p.z * p.z);
	if (l < 0.00001)
	{
		if (p.y > 0.0)
			rot = Vector(0.0,  cast(Float) PI05, 0.0);
		else
			rot = Vector(0.0, -cast(Float) PI05, 0.0);
	}
	else
	{
		if (p.z > 0.0)
			rot.x = -ASin(p.x / l);
		else
			rot.x = cast(Float) PI + ASin(p.x / l);
		rot.y = ATan(p.y / l);
		rot.z = 0.0;
	}
	return rot;
}



Vector PointLineDistance(ref const Vector  p0, ref const Vector  v, ref const Vector  p)
{
	Float vsquare = Dot(v, v);
	if (vsquare == 0.0)
		return Vector(0.0);
	return p - (p0 + Dot(p - p0, v) / vsquare * v);
}

//----------------------------------------------------------------------------------------
/// Calculates where the intersection points are between a line and a sphere in 3D space.
/// @param[in] linePoint1					The first point of the line.
/// @param[in] linePoint2					The second point of the line.
/// @param[in] sphereCenter				The center of the sphere.
/// @param[in] sphereRadius				The radius of the sphere.
/// @param[out] intersection1			(optional) The returned first intersection point (lowest) as an offset between linePoint1 and linePoint2
/// @param[out] intersection2			(optional) The returned second intersection point (highest) as an offset between linePoint1 and linePoint2
/// @param[out] hitPoint1					(optional) The actual 3D point where the line first intersects (enters) the sphere.
/// @param[out] hitPoint2					(optional) The actual 3D point where the line subsequently intersects (exits) the sphere.
/// @return												Bool								Whether the line segment passed intersected the sphere or not.
//----------------------------------------------------------------------------------------
Bool SphereLineIntersection(in Vector linePoint1, in Vector linePoint2, in Vector  sphereCenter, Float sphereRadius, Float *intersection1, Float *intersection2, Vector *hitPoint1, Vector *hitPoint2)
{
	Vector	e = linePoint2 - linePoint1,
			f = linePoint1 - sphereCenter;

	Float		a = Dot(e, e);
	Float		b = 2.0 * Dot(f, e);
	Float		c = Dot(f, f) - sphereRadius * sphereRadius;

	Float		d = b * b - 4 * a * c;

	if (d < 0.0 || a == 0.0)
		return false;							//No intersection

	d = Sqrt(d);
	a *= 2.0;

	Float t1 = (-b - d) / a;
	Float t2 = (-b + d) / a;

	if (intersection1)
		*intersection1 = t1;

	if (intersection2)
		*intersection2 = t2;

	if (hitPoint1)
		*hitPoint1 = linePoint1 + e * t1;

	if (hitPoint2)
		*hitPoint2 = linePoint1 + e * t2;

	return true;
}

//----------------------------------------------------------------------------------------
/// Calculates where the intersection points are between a line and a circle in 2D space (although Z will also be calculated on the resulting hit points)
/// @param[in] linePoint1					The first point of the line.
/// @param[in] linePoint2					The second point of the line.
/// @param[in] circleCenter				The center of the circle.
/// @param[in] circleRadius				The radius of the circle.
/// @param[out] intersection1			(optional) The returned first intersection point (lowest) as an offset between linePoint1 and linePoint2
/// @param[out] intersection2			(optional) The returned second intersection point (highest) as an offset between linePoint1 and linePoint2
/// @param[out] hitPoint1					(optional) The actual point where the line first intersects (enters) the circle, Z may also be calculated.
/// @param[out] hitPoint2					(optional) The actual point where the line subsequently intersects (exits) the circle, Z may also be calculated.
/// @return												Bool								Whether the line segment passed intersected the circle or not.
//----------------------------------------------------------------------------------------
Bool CircleLineIntersection(ref const Vector  linePoint1, ref const Vector  linePoint2, ref const Vector  circleCenter, Float circleRadius, Float *intersection1, Float *intersection2, Vector *hitPoint1, Vector *hitPoint2)
{
	Float offset1, offset2;
	Bool result = SphereLineIntersection(Vector(linePoint1.x, linePoint1.y, 0.0), Vector(linePoint2.x, linePoint2.y, 0.0), Vector(circleCenter.x, circleCenter.y, 0.0), circleRadius, &offset1, &offset2, nullptr, nullptr);

	if (!intersection1 && !intersection2 && !hitPoint1 && !hitPoint2)
		return result;

	Vector e = linePoint2 - linePoint1;

	if (intersection1)
		*intersection1 = offset1;

	if (intersection2)
		*intersection2 = offset2;

	if (hitPoint1)
		*hitPoint1 = linePoint1 + offset1 * e;

	if (hitPoint2)
		*hitPoint2 = linePoint1 + offset2 * e;

	return result;
}
/*
Bool SphereSegmentIntersection(ref const Vector linePoint1,ref const Vector linePoint2,ref const Vector sphereCenter, Float sphereRadius, maxon::BaseArray<SegmentSphereIntersectionData> &intersections)
{
	Float offset1, offset2;
	Vector hitPoint1, hitPoint2;
	if (!SphereLineIntersection(linePoint1, linePoint2, sphereCenter, sphereRadius, &offset1, &offset2, &hitPoint1, &hitPoint2))
		return false;

	if (offset1 >= 0.0 && offset1 <= 1.0 && !intersections.Append(SegmentSphereIntersectionData(offset1, hitPoint1)))
		return false;
	if (offset2 >= 0.0 && offset2 <= 1.0 && !intersections.Append(SegmentSphereIntersectionData(offset2, hitPoint2)))
		return false;

	return (offset1 >= 0.0 && offset1 <= 1.0) || (offset2 >= 0.0 && offset2 <= 1.0);
}
*/

/*
Bool CircleSegmentIntersection(const Vector &linePoint1, const Vector &linePoint2, const Vector &circleCenter, Float circleRadius, maxon::BaseArray<SegmentSphereIntersectionData> &intersections)
{
	Float offset1, offset2;
	if (!SphereLineIntersection(Vector(linePoint1.x, linePoint1.y, 0.0), Vector(linePoint2.x, linePoint2.y, 0.0), Vector(circleCenter.x, circleCenter.y, 0.0), circleRadius, &offset1, &offset2, nullptr, nullptr))
		return false;

	Vector hitPoint1, hitPoint2;
	Vector e = linePoint2 - linePoint1;

	hitPoint1 = linePoint1 + offset1 * e;
	hitPoint2 = linePoint1 + offset2 * e;

	if (offset1 >= 0.0 && offset1 <= 1.0 && !intersections.Append(SegmentSphereIntersectionData(offset1, hitPoint1)))
		return false;
	if (offset2 >= 0.0 && offset2 <= 1.0 && !intersections.Append(SegmentSphereIntersectionData(offset2, hitPoint2)))
		return false;

	return (offset1 >= 0.0 && offset1 <= 1.0) || (offset2 >= 0.0 && offset2 <= 1.0);
}
*/


//=============================================================================
struct Random
{
@safe:
pure:
nothrow:

private:
	UInt32	 seed;
	Int32	 iset;
	Float	 gset;

public:
	this(UInt32 s = 123) {
		iset = 0;
		seed = s;
	}

	/// Converts to a pretty string.
	/*string toString() const {
		import std.string;
		try {
			return format("iset= %s seed= %s", iset, seed);
			//return format("%i %i", iset, seed);
		} catch (Exception e) {
			return "";//assert(false); // should not happen since format is right
		}
	}*/

	void Init(UInt32 s) {
		iset = 0;
		seed = s;
	}

	Float Get01() {	/// return random value between 0 and +1
		const Float teiler = cast(Float)(2147483648.0 + 1.0);	// +1.0, falls evtl. Ungenauigkeiten auftreten
		seed = ((seed + 1) * 69069) & 0x7FFFFFFF;
		return cast(Float)(seed) / teiler;
	}
	Float Get11() {	/// return random value between -1 and +1
		return Get01() * cast(Float) 2.0 - cast(Float) 1.0;
	}

	Float GetG01() {	/// return random value between 0 and +1 with gaussian distribution
		Float fac, rsq, v1, v2;
		if (iset == 0)	{
			do	{
				v1	= Get11();
				v2	= Get11();
				rsq = v1 * v1 + v2 * v2;
			}	while (rsq >= 1.0 || rsq == 0.0);

			fac	 = Sqrt(cast(Float)(-2.0) * Ln(rsq) / rsq);
			gset = v1 * fac;
			iset = 1;
			return v2 * fac * cast(Float) 0.09 + cast(Float) 0.5;
		} else {
			iset = 0;
			return gset * cast(Float) 0.09 + cast(Float) 0.5;
		}
	}
	Float GetG11() {	/// return random value between -1 and +1 with gaussian distribution
		Float fac, rsq, v1, v2;
		if (iset == 0)	{
			do	{
				v1	= Get11();
				v2	= Get11();
				rsq = v1 * v1 + v2 * v2;
			}	while (rsq >= 1.0 || rsq == 0.0);
			fac	 = Sqrt(cast(Float)(-2.0) * Ln(rsq) / rsq);
			gset = v1 * fac;
			iset = 1;
			return v2 * fac * cast(Float) 0.18;
		} else	{
			iset = 0;
			return gset * cast(Float) 0.18;
		}
	}

	Int32 GetSeed() { return seed; }
};


unittest
{
	import core.stdc.stdio;
	//void test() {
	/*	
		Random crnd;// = Random(456);
		pragma(msg,crnd);
		pragma(msg,crnd.Get01);
	*/
	//}

	//Random rnd;
	//rnd.Init(123);

	//printf(" Random %.9f \n",rnd.Get01);

	/*template my_assert(ex){
		assert(ex,ex.stringof);
	}*/

	//? assert(rnd.Get01 == 0.0,(rnd.Get01 == 0.0).stringof);

	/*int[] ai;
	ai.length = 3;
	ai[5] = 1; //range error
	*/
	//try {
	//throw new Exception("test message");
	//} catch(Throwable t){
	//	printf(" Throwable catched ! \n",t);
	//}

	//const int i = 5 + 5;
	//static assert(i == 9);
	/*half a = 1.0f;
	assert (a == 1);
	half b = 2.0f;
	assert (a * 2 == b);
	half c = a + b;
	half d = (b / a - c) ;
	assert (-d == 1);*/
}