package crc640229306f97c153b1;


public class MainActivity_InsetsListener
	extends java.lang.Object
	implements
		mono.android.IGCUserPeer,
		android.view.View.OnApplyWindowInsetsListener
{

	public MainActivity_InsetsListener ()
	{
		super ();
		if (getClass () == MainActivity_InsetsListener.class) {
			mono.android.TypeManager.Activate ("wallpaperTrade.MainActivity+InsetsListener, wallpaperTrade", "", this, new java.lang.Object[] {  });
		}
	}

	public android.view.WindowInsets onApplyWindowInsets (android.view.View p0, android.view.WindowInsets p1)
	{
		return n_onApplyWindowInsets (p0, p1);
	}

	private native android.view.WindowInsets n_onApplyWindowInsets (android.view.View p0, android.view.WindowInsets p1);

	private java.util.ArrayList refList;
	public void monodroidAddReference (java.lang.Object obj)
	{
		if (refList == null)
			refList = new java.util.ArrayList ();
		refList.add (obj);
	}

	public void monodroidClearReferences ()
	{
		if (refList != null)
			refList.clear ();
	}
}
