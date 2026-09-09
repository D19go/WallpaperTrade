package mono.android.widget;


public class RadioGroup_OnCheckedChangeListenerImplementor
	extends java.lang.Object
	implements
		mono.android.IGCUserPeer,
		android.widget.RadioGroup.OnCheckedChangeListener
{

	public RadioGroup_OnCheckedChangeListenerImplementor ()
	{
		super ();
		if (getClass () == RadioGroup_OnCheckedChangeListenerImplementor.class) {
			mono.android.TypeManager.Activate ("Android.Widget.RadioGroup+IOnCheckedChangeListenerImplementor, Mono.Android", "", this, new java.lang.Object[] {  });
		}
	}

	public void onCheckedChanged (android.widget.RadioGroup p0, int p1)
	{
		n_onCheckedChanged (p0, p1);
	}

	private native void n_onCheckedChanged (android.widget.RadioGroup p0, int p1);

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
