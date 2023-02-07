using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace Many2PDFX;

[ComImport]
[CompilerGenerated]
[Guid("EBB5719E-7D23-4FC9-AA37-49C32BC688E5")]
[TypeIdentifier]
public interface IgtMany2PDFX
{
	string InputFile
	{
		[DispId(212)]
		[return: MarshalAs(UnmanagedType.BStr)]
		get;
		[DispId(212)]
		[param: In]
		[param: MarshalAs(UnmanagedType.BStr)]
		set;
	}

	string OutputPDFFileName
	{
		[DispId(213)]
		[return: MarshalAs(UnmanagedType.BStr)]
		get;
		[DispId(213)]
		[param: In]
		[param: MarshalAs(UnmanagedType.BStr)]
		set;
	}

	bool Visible
	{
		[DispId(233)]
		get;
		[DispId(233)]
		[param: In]
		set;
	}

	bool PrefOpenAfterCreate
	{
		[DispId(201)]
		get;
		[DispId(201)]
		[param: In]
		set;
	}

	bool PrefShowSetupDialog
	{
		[DispId(208)]
		get;
		[DispId(208)]
		[param: In]
		set;
	}

	string DocInfoAuthor
	{
		[DispId(232)]
		[return: MarshalAs(UnmanagedType.BStr)]
		get;
		[DispId(232)]
		[param: In]
		[param: MarshalAs(UnmanagedType.BStr)]
		set;
	}

	TxgtPrinterOrientation PageOrientation
	{
		[DispId(238)]
		get;
		[DispId(238)]
		[param: In]
		set;
	}

	TxgtPaperSize PagePaperSize
	{
		[DispId(239)]
		get;
		[DispId(239)]
		[param: In]
		set;
	}

	double PageLeftMargin
	{
		[DispId(242)]
		get;
		[DispId(242)]
		[param: In]
		set;
	}

	double PageTopMargin
	{
		[DispId(244)]
		get;
		[DispId(244)]
		[param: In]
		set;
	}

	double PageBottomMargin
	{
		[DispId(245)]
		get;
		[DispId(245)]
		[param: In]
		set;
	}

	void _VtblGap1_2();

	void _VtblGap2_27();

	void _VtblGap3_4();

	void _VtblGap4_7();

	void _VtblGap5_8();

	void _VtblGap6_4();

	void _VtblGap7_2();

	void _VtblGap8_13();

	[DispId(229)]
	bool ActivateLicense([In][MarshalAs(UnmanagedType.BStr)] string LicenseKey);

	void _VtblGap9_19();

	[DispId(209)]
	bool RenderDocument();
}
