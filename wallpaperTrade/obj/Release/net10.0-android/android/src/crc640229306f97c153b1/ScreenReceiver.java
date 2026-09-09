package crc640229306f97c153b1;


public class ScreenReceiver
	extends android.content.BroadcastReceiver
	implements
		mono.android.IGCUserPeer
{

	public ScreenReceiver ()
	{
		super ();
		if (getClass () == ScreenReceiver.class) {
			mono.android.TypeManager.Activate ("wallpaperTrade.ScreenReceiver, wallpaperTrade", "", this, new java.lang.Object[] {  });
		}
	}

	public void onReceive (android.content.Context p0, android.content.Intent p1)
	{
		n_onReceive (p0, p1);
	}

	private native void n_onReceive (android.content.Context p0, android.content.Intent p1);

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
