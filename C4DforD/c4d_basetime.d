
module c4d_basetime;

import c4d;
import c4d_os;

void CriticalStop() {} //TODO 


static assert(BaseTime.sizeof==16,"sizeof BaseTime is not 16 bytes !");
//===============================================================================
struct BaseTime
{
//private:
public:
	Float numerator   = 0.0;
	Float denominator = 1.0;
public:
	//this() { numerator = 0.0; denominator = 1.0; }

	//@disable 
	this(this){ printf(" BaseTime postblit \n"); } 

	//this(Float r); //explicit BaseTime(Float r);
	this(Float r)
	{
		if (r > cast(Float) 1.0e15)
			r = cast(Float) 1.0e15;
		if (r < cast(Float) - 1.0e15)
			r = cast(Float) - 1.0e15;
		numerator = Floor(r * cast(Float) 1000.0 + cast(Float) 0.5);
		denominator = cast(Float) 1000.0;
		Reduce();
	}

	//this(Float z, Float n); //explicit BaseTime(Float z, Float n);
	this(Float z, Float n)
	{
		Bool sgn = (z >= 0.0) == (n >= 0.0);

		numerator = Floor(Abs(z) + cast(Float) 0.5);
		denominator = Floor(Abs(n) + cast(Float) 0.5);
		if (denominator < cast(Float) 1.0)
		{
			CriticalStop();
			denominator = 1.0;
		}

		if (!sgn)
			numerator = -numerator;
		Reduce();
	}

	Float Get() const
	{
		if (denominator == 0.0)
			return 0.0;
		return numerator / denominator;
	}

	Float GetNumerator() const { return numerator; }
	Float GetDenominator() const { return denominator; }

	void SetNumerator(Float r) { numerator = r;	}
	void SetDenominator(Float r);

	Int32 GetFrame(Float fps) const { return cast(Int32)(Floor(numerator * fps) / Floor(denominator)); }
	void Quantize(Float fps) {
		if (fps < cast(Float)1.0) {
			CriticalStop();
			fps = 1.0;
		}
		numerator = Floor(Floor(numerator * fps) / Floor(denominator));
		denominator = Floor(fps);
		Reduce();
	}
/*
	friend const BaseTime operator *  (const BaseTime& t1, const BaseTime& t2);
	friend const BaseTime operator /  (const BaseTime& t1, const BaseTime& t2);

	friend const BaseTime operator +  (const BaseTime& t1, const BaseTime& t2);
	friend const BaseTime operator -  (const BaseTime& t1, const BaseTime& t2);

	friend Bool operator == (const BaseTime& t1, const BaseTime& t2);
	friend Bool operator <  (const BaseTime& t1, const BaseTime& t2);
	friend Bool operator != (const BaseTime& t1, const BaseTime& t2);
	friend Bool operator <= (const BaseTime& t1, const BaseTime& t2);
	friend Bool operator >= (const BaseTime& t1, const BaseTime& t2);
	friend Bool operator >  (const BaseTime& t1, const BaseTime& t2);
*/
	Int32 TimeDif(ref const BaseTime  t2) const
	{
		Float n1 = GetNumerator();
		Float n2 = t2.GetNumerator();
		Float d1 = GetDenominator();
		Float d2 = t2.GetDenominator();
		if (n1 == n2 && d1 == d2)
			return 0;

		Float nd1 = Floor(n1 * d2);
		Float nd2 = Floor(n2 * d1);
		if (nd1 < nd2)
			return -1;
		else if (nd1 > nd2)
			return 1;
		return 0;
	}


	void Reduce()
	{
		Float z, n, m;

		z = Abs(numerator);
		n = Abs(denominator);

		if (z < 0.001 || n < 0.001)
		{
			numerator = 0.0;
			denominator = 1.0;
		}
		else if (z < MAXVALUE_INT32_FLOAT32 && n < MAXVALUE_INT32_FLOAT32)
		{
			Int32 iz = cast(Int32)z, iw = cast(Int32)n, im;

			if (iw == 0)	// failsafe
			{
				numerator = 0.0;
				denominator = 1.0;
			}
			else
			{
				do
				{
					im = iz % iw;
					iz = iw; iw = im;
				} while (im);

				numerator /= cast(Float)(iz);
				denominator /= cast(Float)(iz);
			}
		}
		else
		{
			Float64 div = 1.0e18 / FMax(cast(Float64)(z), cast(Float64)(n));
			if (div < 1.0)
			{
				z *= div;
				n *= div;
				numerator *= div;
				denominator *= div;
			}
			if (n < 1.0)
			{
				n = 1.0; denominator = 1.0;
			}

			do
			{
				m = FMod(z, n);
				z = n; n = m;
			} while (m >= 0.5);

			numerator /= z;
			denominator /= z;
		}
	}
};
/*
BaseTime::this(Float r)
{
	if (r > (Float) 1.0e15)
		r = (Float) 1.0e15;
	if (r < (Float) - 1.0e15)
		r = (Float) - 1.0e15;
	numerator = Floor(r * (Float) 1000.0 + (Float) 0.5);
	denominator = (Float) 1000.0;
	Reduce();
}

BaseTime::this(Float z, Float n)
{
	Bool sgn = (z >= 0.0) == (n >= 0.0);

	numerator = Floor(Abs(z) + (Float) 0.5);
	denominator = Floor(Abs(n) + (Float) 0.5);
	if (denominator < (Float) 1.0)
	{
		CriticalStop();
		denominator = 1.0;
	}

	if (!sgn)
		numerator = -numerator;
	Reduce();
}

void BaseTime::SetDenominator(Float r)
{
	denominator = r;
	if (denominator < (Float) 1.0)
	{
		CriticalStop();
		denominator = 1.0;
	}
}

void BaseTime::Quantize(Float fps)
{
	if (fps < (Float) 1.0)
	{
		CriticalStop();
		fps = 1.0;
	}
	numerator = Floor(Floor(numerator * fps) / Floor(denominator));
	denominator = Floor(fps);
	Reduce();
}

void BaseTime::Reduce()
{
	Float z, n, m;

	z = Abs(numerator);
	n = Abs(denominator);

	if (z < 0.001 || n < 0.001)
	{
		numerator = 0.0;
		denominator = 1.0;
	}
	else if (z < MAXVALUE_INT32_FLOAT32 && n < MAXVALUE_INT32_FLOAT32)
	{
		Int32 iz = (Int32)z, in = (Int32)n, im;

		if (in == 0)	// failsafe
		{
			numerator = 0.0;
			denominator = 1.0;
		}
		else
		{
			do
			{
				im = iz % in;
				iz = in; in = im;
			} while (im);

			numerator /= Float(iz);
			denominator /= Float(iz);
		}
	}
	else
	{
		Float64 div = 1.0e18 / FMax(Float64(z), Float64(n));
		if (div < 1.0)
		{
			z *= div;
			n *= div;
			numerator *= div;
			denominator *= div;
		}
		if (n < 1.0)
		{
			n = 1.0; denominator = 1.0;
		}

		do
		{
			m = FMod(z, n);
			z = n; n = m;
		} while (m >= 0.5);

		numerator /= z;
		denominator /= z;
	}
}
*/

/*
inline const BaseTime operator * (const BaseTime& t1, const BaseTime& t2)
{
	return BaseTime(t1.numerator * t2.numerator, t1.denominator * t2.denominator);
}

inline const BaseTime operator / (const BaseTime& t1, const BaseTime& t2)
{
	return BaseTime(t1.numerator * t2.denominator, t1.denominator * t2.numerator);
}

inline const BaseTime operator + (const BaseTime& t1, const BaseTime& t2)
{
	return BaseTime(t1.numerator * t2.denominator + t2.numerator * t1.denominator, t1.denominator * t2.denominator);
}

inline const BaseTime operator - (const BaseTime& t1, const BaseTime& t2)
{
	return BaseTime(t1.numerator * t2.denominator - t2.numerator * t1.denominator, t1.denominator * t2.denominator);
}

inline Bool operator == (const BaseTime& t1, const BaseTime& t2)
{
	if (t1.numerator == t2.numerator && t1.denominator == t2.denominator)
		return true;	// massive problems otherwise (compiler miscalculating floor)
	return Floor(t1.numerator * t2.denominator) == Floor(t2.numerator * t1.denominator);
}

inline Bool operator < (const BaseTime& t1, const BaseTime& t2)
{
	if (t1.numerator == t2.numerator && t1.denominator == t2.denominator)
		return false;		// massive problems otherwise (compiler miscalculating floor)
	return Floor(t1.numerator * t2.denominator) < Floor(t2.numerator * t1.denominator);
}

inline Bool operator != (const BaseTime& t1, const BaseTime& t2)
{
	if (t1.numerator == t2.numerator && t1.denominator == t2.denominator)
		return false;		// massive problems otherwise (compiler miscalculating floor)
	return Floor(t1.numerator * t2.denominator) != Floor(t2.numerator * t1.denominator);
}

inline Bool operator <= (const BaseTime& t1, const BaseTime& t2)
{
	if (t1.numerator == t2.numerator && t1.denominator == t2.denominator)
		return true;	// massive problems otherwise (compiler miscalculating floor)
	return Floor(t1.numerator * t2.denominator) <= Floor(t2.numerator * t1.denominator);
}

inline Bool operator >= (const BaseTime& t1, const BaseTime& t2)
{
	if (t1.numerator == t2.numerator && t1.denominator == t2.denominator)
		return true;	// massive problems otherwise (compiler miscalculating floor)
	return Floor(t1.numerator * t2.denominator) >= Floor(t2.numerator * t1.denominator);
}

inline Bool operator > (const BaseTime& t1, const BaseTime& t2)
{
	if (t1.numerator == t2.numerator && t1.denominator == t2.denominator)
		return false;		// massive problems otherwise (compiler miscalculating floor)
	return Floor(t1.numerator * t2.denominator) > Floor(t2.numerator * t1.denominator);
}
*/