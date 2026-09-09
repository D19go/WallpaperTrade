; ModuleID = 'marshal_methods.x86_64.ll'
source_filename = "marshal_methods.x86_64.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [14 x ptr] zeroinitializer, align 16

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [42 x i64] [
	i64 u0x02abedc11addc1ed, ; 0: lib_Mono.Android.Runtime.dll.so => 12
	i64 u0x0581db89237110e9, ; 1: lib_System.Collections.dll.so => 2
	i64 u0x09d144a7e214d457, ; 2: System.Security.Cryptography => 7
	i64 u0x0c59ad9fbbd43abe, ; 3: Mono.Android => 13
	i64 u0x13f1e5e209e91af4, ; 4: lib_Java.Interop.dll.so => 11
	i64 u0x1c753b5ff15bce1b, ; 5: Mono.Android.Runtime.dll => 12
	i64 u0x2174319c0d835bc9, ; 6: System.Runtime => 6
	i64 u0x237be844f1f812c7, ; 7: System.Threading.Thread.dll => 8
	i64 u0x2407aef2bbe8fadf, ; 8: System.Console => 3
	i64 u0x27b410442fad6cf1, ; 9: Java.Interop.dll => 11
	i64 u0x2d169d318a968379, ; 10: System.Threading.dll => 9
	i64 u0x31195fef5d8fb552, ; 11: _Microsoft.Android.Resource.Designer.dll => 0
	i64 u0x375a55a71a93298a, ; 12: wallpaperTrade.dll => 1
	i64 u0x434c4e1d9284cdae, ; 13: Mono.Android.dll => 13
	i64 u0x4ac13f7cd8a4fac3, ; 14: wallpaperTrade => 1
	i64 u0x4e32f00cb0937401, ; 15: Mono.Android.Runtime => 12
	i64 u0x54795225dd1587af, ; 16: lib_System.Runtime.dll.so => 6
	i64 u0x579a06fed6eec900, ; 17: System.Private.CoreLib.dll => 10
	i64 u0x5a8f6699f4a1caa9, ; 18: lib_System.Threading.dll.so => 9
	i64 u0x5db0cbbd1028510e, ; 19: lib_System.Runtime.InteropServices.dll.so => 5
	i64 u0x622eef6f9e59068d, ; 20: System.Private.CoreLib => 10
	i64 u0x6692e924eade1b29, ; 21: lib_System.Console.dll.so => 3
	i64 u0x6a4d7577b2317255, ; 22: System.Runtime.InteropServices.dll => 5
	i64 u0x7dfc3d6d9d8d7b70, ; 23: System.Collections => 2
	i64 u0x87c69b87d9283884, ; 24: lib_System.Threading.Thread.dll.so => 8
	i64 u0x8d7b8ab4b3310ead, ; 25: System.Threading => 9
	i64 u0x903101b46fb73a04, ; 26: _Microsoft.Android.Resource.Designer => 0
	i64 u0x91a74f07b30d37e2, ; 27: System.Linq.dll => 4
	i64 u0xa0d8259f4cc284ec, ; 28: lib_System.Security.Cryptography.dll.so => 7
	i64 u0xa5f1ba49b85dd355, ; 29: System.Security.Cryptography.dll => 7
	i64 u0xad8cab607060ce4c, ; 30: lib_wallpaperTrade.dll.so => 1
	i64 u0xae282bcd03739de7, ; 31: Java.Interop => 11
	i64 u0xb81a2c6e0aee50fe, ; 32: lib_System.Private.CoreLib.dll.so => 10
	i64 u0xba48785529705af9, ; 33: System.Collections.dll => 2
	i64 u0xc0d928351ab5ca77, ; 34: System.Console.dll => 3
	i64 u0xc12b8b3afa48329c, ; 35: lib_System.Linq.dll.so => 4
	i64 u0xcbd4fdd9cef4a294, ; 36: lib__Microsoft.Android.Resource.Designer.dll.so => 0
	i64 u0xd333d0af9e423810, ; 37: System.Runtime.InteropServices => 5
	i64 u0xdbf9607a441b4505, ; 38: System.Linq => 4
	i64 u0xdd2b722d78ef5f43, ; 39: System.Runtime.dll => 6
	i64 u0xe5434e8a119ceb69, ; 40: lib_Mono.Android.dll.so => 13
	i64 u0xfa645d91e9fc4cba ; 41: System.Threading.Thread => 8
], align 16

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [42 x i32] [
	i32 12, i32 2, i32 7, i32 13, i32 11, i32 12, i32 6, i32 8,
	i32 3, i32 11, i32 9, i32 0, i32 1, i32 13, i32 1, i32 12,
	i32 6, i32 10, i32 9, i32 5, i32 10, i32 3, i32 5, i32 2,
	i32 8, i32 9, i32 0, i32 4, i32 7, i32 7, i32 1, i32 11,
	i32 10, i32 2, i32 3, i32 4, i32 0, i32 5, i32 4, i32 6,
	i32 13, i32 8
], align 16

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 12, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [12 x %struct.MarshalMethodsManagedClass] [
	%struct.MarshalMethodsManagedClass {
		i32 u0x02000064, ; class name: Android.Widget.CompoundButton/IOnCheckedChangeListenerInvoker, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
		ptr null; MonoClass* klass
	}, ; 0
	%struct.MarshalMethodsManagedClass {
		i32 u0x02000075, ; class name: Android.Widget.RadioGroup/IOnCheckedChangeListenerInvoker, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
		ptr null; MonoClass* klass
	}, ; 1
	%struct.MarshalMethodsManagedClass {
		i32 u0x02000099, ; class name: Android.Views.View/IOnClickListenerInvoker, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
		ptr null; MonoClass* klass
	}, ; 2
	%struct.MarshalMethodsManagedClass {
		i32 u0x0200011c, ; class name: Java.IO.InputStream, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
		ptr null; MonoClass* klass
	}, ; 3
	%struct.MarshalMethodsManagedClass {
		i32 u0x02000132, ; class name: Java.Lang.Object, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
		ptr null; MonoClass* klass
	}, ; 4
	%struct.MarshalMethodsManagedClass {
		i32 u0x0200011f, ; class name: Java.IO.OutputStream, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
		ptr null; MonoClass* klass
	}, ; 5
	%struct.MarshalMethodsManagedClass {
		i32 u0x02000144, ; class name: Java.Lang.IRunnableInvoker, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
		ptr null; MonoClass* klass
	}, ; 6
	%struct.MarshalMethodsManagedClass {
		i32 u0x020000e9, ; class name: Android.Content.BroadcastReceiver, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
		ptr null; MonoClass* klass
	}, ; 7
	%struct.MarshalMethodsManagedClass {
		i32 u0x02000102, ; class name: Android.App.Activity, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
		ptr null; MonoClass* klass
	}, ; 8
	%struct.MarshalMethodsManagedClass {
		i32 u0x02000097, ; class name: Android.Views.View/IOnApplyWindowInsetsListenerInvoker, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
		ptr null; MonoClass* klass
	}, ; 9
	%struct.MarshalMethodsManagedClass {
		i32 u0x0200010d, ; class name: Android.App.Service, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
		ptr null; MonoClass* klass
	}, ; 10
	%struct.MarshalMethodsManagedClass {
		i32 u0x0200015c, ; class name: Java.Interop.TypeManager/JavaTypeManager, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
		ptr null; MonoClass* klass
	} ; 11
], align 16

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [12 x ptr] [
	ptr @.mm.0, ; 0 ('Android.Widget.CompoundButton/IOnCheckedChangeListenerInvoker, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065')
	ptr @.mm.1, ; 1 ('Android.Widget.RadioGroup/IOnCheckedChangeListenerInvoker, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065')
	ptr @.mm.2, ; 2 ('Android.Views.View/IOnClickListenerInvoker, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065')
	ptr @.mm.3, ; 3 ('Java.IO.InputStream, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065')
	ptr @.mm.4, ; 4 ('Java.Lang.Object, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065')
	ptr @.mm.5, ; 5 ('Java.IO.OutputStream, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065')
	ptr @.mm.6, ; 6 ('Java.Lang.IRunnableInvoker, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065')
	ptr @.mm.7, ; 7 ('Android.Content.BroadcastReceiver, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065')
	ptr @.mm.8, ; 8 ('Android.App.Activity, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065')
	ptr @.mm.9, ; 9 ('Android.Views.View/IOnApplyWindowInsetsListenerInvoker, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065')
	ptr @.mm.10, ; 10 ('Android.App.Service, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065')
	ptr @.mm.11 ; 11 ('Java.Interop.TypeManager/JavaTypeManager, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065')
], align 16

@mm_method_names = dso_local local_unnamed_addr constant [27 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 u0x0000000d060001bd, ; name: n_OnCheckedChanged_Landroid_widget_CompoundButton_Z_mm_wrapper(IntPtr,IntPtr,IntPtr,SByte)
		ptr @.MarshalMethodName.0_name; char* name
	}, ; 0
	%struct.MarshalMethodName {
		i64 u0x0000000d0600022a, ; name: n_OnCheckedChanged_Landroid_widget_RadioGroup_I_mm_wrapper(IntPtr,IntPtr,IntPtr,Int32)
		ptr @.MarshalMethodName.1_name; char* name
	}, ; 1
	%struct.MarshalMethodName {
		i64 u0x0000000d06000385, ; name: n_OnClick_Landroid_view_View__mm_wrapper(IntPtr,IntPtr,IntPtr)
		ptr @.MarshalMethodName.2_name; char* name
	}, ; 2
	%struct.MarshalMethodName {
		i64 u0x0000000d060008be, ; name: n_Close_mm_wrapper(IntPtr,IntPtr)
		ptr @.MarshalMethodName.3_name; char* name
	}, ; 3
	%struct.MarshalMethodName {
		i64 u0x0000000d060008bf, ; name: n_Read_mm_wrapper(IntPtr,IntPtr)
		ptr @.MarshalMethodName.4_name; char* name
	}, ; 4
	%struct.MarshalMethodName {
		i64 u0x0000000d060008c0, ; name: n_Read_arrayB_mm_wrapper(IntPtr,IntPtr,IntPtr)
		ptr @.MarshalMethodName.5_name; char* name
	}, ; 5
	%struct.MarshalMethodName {
		i64 u0x0000000d060008c1, ; name: n_Read_arrayBII_mm_wrapper(IntPtr,IntPtr,IntPtr,Int32,Int32)
		ptr @.MarshalMethodName.6_name; char* name
	}, ; 6
	%struct.MarshalMethodName {
		i64 u0x0000000d06000a57, ; name: n_Equals_Ljava_lang_Object__mm_wrapper(IntPtr,IntPtr,IntPtr)
		ptr @.MarshalMethodName.7_name; char* name
	}, ; 7
	%struct.MarshalMethodName {
		i64 u0x0000000d06000a58, ; name: n_GetHashCode_mm_wrapper(IntPtr,IntPtr)
		ptr @.MarshalMethodName.8_name; char* name
	}, ; 8
	%struct.MarshalMethodName {
		i64 u0x0000000d06000a59, ; name: n_ToString_mm_wrapper(IntPtr,IntPtr)
		ptr @.MarshalMethodName.9_name; char* name
	}, ; 9
	%struct.MarshalMethodName {
		i64 u0x0000000d060008df, ; name: n_Close_mm_wrapper(IntPtr,IntPtr)
		ptr @.MarshalMethodName.3_name; char* name
	}, ; 10
	%struct.MarshalMethodName {
		i64 u0x0000000d060008e0, ; name: n_Flush_mm_wrapper(IntPtr,IntPtr)
		ptr @.MarshalMethodName.10_name; char* name
	}, ; 11
	%struct.MarshalMethodName {
		i64 u0x0000000d060008e1, ; name: n_Write_arrayB_mm_wrapper(IntPtr,IntPtr,IntPtr)
		ptr @.MarshalMethodName.11_name; char* name
	}, ; 12
	%struct.MarshalMethodName {
		i64 u0x0000000d060008e2, ; name: n_Write_arrayBII_mm_wrapper(IntPtr,IntPtr,IntPtr,Int32,Int32)
		ptr @.MarshalMethodName.12_name; char* name
	}, ; 13
	%struct.MarshalMethodName {
		i64 u0x0000000d060008e3, ; name: n_Write_I_mm_wrapper(IntPtr,IntPtr,Int32)
		ptr @.MarshalMethodName.13_name; char* name
	}, ; 14
	%struct.MarshalMethodName {
		i64 u0x0000000d06000b06, ; name: n_Run_mm_wrapper(IntPtr,IntPtr)
		ptr @.MarshalMethodName.14_name; char* name
	}, ; 15
	%struct.MarshalMethodName {
		i64 u0x0000000d060006cf, ; name: n_OnReceive_Landroid_content_Context_Landroid_content_Intent__mm_wrapper(IntPtr,IntPtr,IntPtr,IntPtr)
		ptr @.MarshalMethodName.15_name; char* name
	}, ; 16
	%struct.MarshalMethodName {
		i64 u0x0000000d060007f4, ; name: n_OnCreate_Landroid_os_Bundle__mm_wrapper(IntPtr,IntPtr,IntPtr)
		ptr @.MarshalMethodName.16_name; char* name
	}, ; 17
	%struct.MarshalMethodName {
		i64 u0x0000000d060007f5, ; name: n_OnResume_mm_wrapper(IntPtr,IntPtr)
		ptr @.MarshalMethodName.17_name; char* name
	}, ; 18
	%struct.MarshalMethodName {
		i64 u0x0000000d060007f6, ; name: n_OnActivityResult_IILandroid_content_Intent__mm_wrapper(IntPtr,IntPtr,Int32,Int32,IntPtr)
		ptr @.MarshalMethodName.18_name; char* name
	}, ; 19
	%struct.MarshalMethodName {
		i64 u0x0000000d06000379, ; name: n_OnApplyWindowInsets_Landroid_view_View_Landroid_view_WindowInsets__mm_wrapper(IntPtr,IntPtr,IntPtr,IntPtr)
		ptr @.MarshalMethodName.19_name; char* name
	}, ; 20
	%struct.MarshalMethodName {
		i64 u0x0000000d0600084d, ; name: n_OnCreate_mm_wrapper(IntPtr,IntPtr)
		ptr @.MarshalMethodName.20_name; char* name
	}, ; 21
	%struct.MarshalMethodName {
		i64 u0x0000000d0600084e, ; name: n_OnStartCommand_Landroid_content_Intent_II_mm_wrapper(IntPtr,IntPtr,IntPtr,Int32,Int32)
		ptr @.MarshalMethodName.21_name; char* name
	}, ; 22
	%struct.MarshalMethodName {
		i64 u0x0000000d0600084f, ; name: n_OnDestroy_mm_wrapper(IntPtr,IntPtr)
		ptr @.MarshalMethodName.22_name; char* name
	}, ; 23
	%struct.MarshalMethodName {
		i64 u0x0000000d06000850, ; name: n_OnBind_Landroid_content_Intent__mm_wrapper(IntPtr,IntPtr,IntPtr)
		ptr @.MarshalMethodName.23_name; char* name
	}, ; 24
	%struct.MarshalMethodName {
		i64 u0x0000000d06000bb1, ; name: n_Activate_mm(IntPtr,IntPtr,IntPtr,IntPtr,IntPtr,IntPtr)
		ptr @.MarshalMethodName.24_name; char* name
	}, ; 25
	%struct.MarshalMethodName {
		i64 u0x0000000000000000, ; name: 
		ptr @.MarshalMethodName.25_name; char* name
	} ; 26
], align 16

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 8

; Marshal methods backing fields, pointers to native functions
@native_cb_onCheckedChanged_0_0_60001bd = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_onCheckedChanged_0_1_600022a = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_onClick_0_2_6000385 = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_close_0_3_60008be = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_read_0_3_60008bf = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_read_0_3_60008c0 = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_read_0_3_60008c1 = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_equals_0_4_6000a57 = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_hashCode_0_4_6000a58 = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_toString_0_4_6000a59 = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_close_0_5_60008df = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_flush_0_5_60008e0 = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_write_0_5_60008e1 = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_write_0_5_60008e2 = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_write_0_5_60008e3 = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_run_0_6_6000b06 = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_onReceive_0_7_60006cf = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_onCreate_0_8_60007f4 = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_onResume_0_8_60007f5 = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_onActivityResult_0_8_60007f6 = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_onApplyWindowInsets_0_9_6000379 = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_onCreate_0_10_600084d = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_onStartCommand_0_10_600084e = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_onDestroy_0_10_600084f = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_onBind_0_10_6000850 = internal dso_local unnamed_addr global ptr null, align 8
@native_cb_activate_0_11_6000bb1 = internal dso_local unnamed_addr global ptr null, align 8

; Functions

; Function attributes: memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.mm.12)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 8, !tbaa !3
	ret void
}

; Method: System.Void Android.Widget.CompoundButton/IOnCheckedChangeListenerInvoker::n_OnCheckedChanged_Landroid_widget_CompoundButton_Z_mm_wrapper(System.IntPtr,System.IntPtr,System.IntPtr,System.SByte)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Android.Widget.CompoundButton/IOnCheckedChangeListener::OnCheckedChanged(Android.Widget.CompoundButton,System.Boolean)
; Implemented: System.Void Android.Widget.CompoundButton/IOnCheckedChangeListener::OnCheckedChanged(Android.Widget.CompoundButton,System.Boolean)
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_mono_android_widget_CompoundButton_1OnCheckedChangeListenerImplementor_n_1onCheckedChanged(ptr noundef %env, ptr noundef %klass, ptr noundef %0, i1 noundef zeroext %1) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_onCheckedChanged_0_0_60001bd, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %2
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 0, i32 noundef 100663741, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_onCheckedChanged_0_0_60001bd)
	%cb2 = load ptr, ptr @native_cb_onCheckedChanged_0_0_60001bd, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %2
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %2]
	tail call void %fn(ptr noundef %env, ptr noundef %klass, ptr noundef %0, i1 noundef zeroext %1)
	ret void
}

; Method: System.Void Android.Widget.RadioGroup/IOnCheckedChangeListenerInvoker::n_OnCheckedChanged_Landroid_widget_RadioGroup_I_mm_wrapper(System.IntPtr,System.IntPtr,System.IntPtr,System.Int32)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Android.Widget.RadioGroup/IOnCheckedChangeListener::OnCheckedChanged(Android.Widget.RadioGroup,System.Int32)
; Implemented: System.Void Android.Widget.RadioGroup/IOnCheckedChangeListener::OnCheckedChanged(Android.Widget.RadioGroup,System.Int32)
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_mono_android_widget_RadioGroup_1OnCheckedChangeListenerImplementor_n_1onCheckedChanged(ptr noundef %env, ptr noundef %klass, ptr noundef %0, i32 noundef %1) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_onCheckedChanged_0_1_600022a, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %2
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 1, i32 noundef 100663850, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_onCheckedChanged_0_1_600022a)
	%cb2 = load ptr, ptr @native_cb_onCheckedChanged_0_1_600022a, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %2
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %2]
	tail call void %fn(ptr noundef %env, ptr noundef %klass, ptr noundef %0, i32 noundef %1)
	ret void
}

; Method: System.Void Android.Views.View/IOnClickListenerInvoker::n_OnClick_Landroid_view_View__mm_wrapper(System.IntPtr,System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Android.Views.View/IOnClickListener::OnClick(Android.Views.View)
; Implemented: System.Void Android.Views.View/IOnClickListener::OnClick(Android.Views.View)
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_mono_android_view_View_1OnClickListenerImplementor_n_1onClick(ptr noundef %env, ptr noundef %klass, ptr noundef %0) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_onClick_0_2_6000385, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %1
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 2, i32 noundef 100664197, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_onClick_0_2_6000385)
	%cb2 = load ptr, ptr @native_cb_onClick_0_2_6000385, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %1
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %1]
	tail call void %fn(ptr noundef %env, ptr noundef %klass, ptr noundef %0)
	ret void
}

; Method: System.Void Java.IO.InputStream::n_Close_mm_wrapper(System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Java.IO.InputStream::Close()
; Implemented: System.Void Android.Runtime.InputStreamAdapter::Close()
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_mono_android_runtime_InputStreamAdapter_n_1close(ptr noundef %env, ptr noundef %klass) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_close_0_3_60008be, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 3, i32 noundef 100665534, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_close_0_3_60008be)
	%cb2 = load ptr, ptr @native_cb_close_0_3_60008be, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	tail call void %fn(ptr noundef %env, ptr noundef %klass)
	ret void
}

; Method: System.Int32 Java.IO.InputStream::n_Read_mm_wrapper(System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Int32 Java.IO.InputStream::Read()
; Implemented: System.Int32 Android.Runtime.InputStreamAdapter::Read()
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define i32 @Java_mono_android_runtime_InputStreamAdapter_n_1read__(ptr noundef %env, ptr noundef %klass) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_read_0_3_60008bf, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 3, i32 noundef 100665535, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_read_0_3_60008bf)
	%cb2 = load ptr, ptr @native_cb_read_0_3_60008bf, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	%1 = tail call noundef i32 %fn(ptr noundef %env, ptr noundef %klass)
	ret i32 %1
}

; Method: System.Int32 Java.IO.InputStream::n_Read_arrayB_mm_wrapper(System.IntPtr,System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Int32 Java.IO.InputStream::Read(System.Byte[])
; Implemented: System.Int32 Android.Runtime.InputStreamAdapter::Read(System.Byte[])
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define i32 @Java_mono_android_runtime_InputStreamAdapter_n_1read___3B(ptr noundef %env, ptr noundef %klass, ptr noundef %bytes) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_read_0_3_60008c0, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 3, i32 noundef 100665536, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_read_0_3_60008c0)
	%cb2 = load ptr, ptr @native_cb_read_0_3_60008c0, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	%1 = tail call noundef i32 %fn(ptr noundef %env, ptr noundef %klass, ptr noundef %bytes)
	ret i32 %1
}

; Method: System.Int32 Java.IO.InputStream::n_Read_arrayBII_mm_wrapper(System.IntPtr,System.IntPtr,System.IntPtr,System.Int32,System.Int32)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Int32 Java.IO.InputStream::Read(System.Byte[],System.Int32,System.Int32)
; Implemented: System.Int32 Android.Runtime.InputStreamAdapter::Read(System.Byte[],System.Int32,System.Int32)
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define i32 @Java_mono_android_runtime_InputStreamAdapter_n_1read___3BII(ptr noundef %env, ptr noundef %klass, ptr noundef %bytes, i32 noundef %offset, i32 noundef %length) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_read_0_3_60008c1, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 3, i32 noundef 100665537, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_read_0_3_60008c1)
	%cb2 = load ptr, ptr @native_cb_read_0_3_60008c1, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	%1 = tail call noundef i32 %fn(ptr noundef %env, ptr noundef %klass, ptr noundef %bytes, i32 noundef %offset, i32 noundef %length)
	ret i32 %1
}

; Method: System.SByte Java.Lang.Object::n_Equals_Ljava_lang_Object__mm_wrapper(System.IntPtr,System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Boolean Java.Lang.Object::Equals(Java.Lang.Object)
; Implemented: System.Boolean Android.Runtime.JavaObject::Equals(Java.Lang.Object)
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define i1 @Java_mono_android_runtime_JavaObject_n_1equals(ptr noundef %env, ptr noundef %klass, ptr noundef %0) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_equals_0_4_6000a57, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %1
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 4, i32 noundef 100665943, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_equals_0_4_6000a57)
	%cb2 = load ptr, ptr @native_cb_equals_0_4_6000a57, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %1
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %1]
	%2 = tail call noundef i1 %fn(ptr noundef %env, ptr noundef %klass, ptr noundef %0)
	ret i1 %2
}

; Method: System.Int32 Java.Lang.Object::n_GetHashCode_mm_wrapper(System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Int32 Java.Lang.Object::GetHashCode()
; Implemented: System.Int32 Android.Runtime.JavaObject::GetHashCode()
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define i32 @Java_mono_android_runtime_JavaObject_n_1hashCode(ptr noundef %env, ptr noundef %klass) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_hashCode_0_4_6000a58, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 4, i32 noundef 100665944, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_hashCode_0_4_6000a58)
	%cb2 = load ptr, ptr @native_cb_hashCode_0_4_6000a58, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	%1 = tail call noundef i32 %fn(ptr noundef %env, ptr noundef %klass)
	ret i32 %1
}

; Method: System.IntPtr Java.Lang.Object::n_ToString_mm_wrapper(System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.String Java.Lang.Object::ToString()
; Implemented: System.String Android.Runtime.JavaObject::ToString()
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define ptr @Java_mono_android_runtime_JavaObject_n_1toString(ptr noundef %env, ptr noundef %klass) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_toString_0_4_6000a59, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 4, i32 noundef 100665945, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_toString_0_4_6000a59)
	%cb2 = load ptr, ptr @native_cb_toString_0_4_6000a59, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	%1 = tail call noundef ptr %fn(ptr noundef %env, ptr noundef %klass)
	ret ptr %1
}

; Method: System.Void Java.IO.OutputStream::n_Close_mm_wrapper(System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Java.IO.OutputStream::Close()
; Implemented: System.Void Android.Runtime.OutputStreamAdapter::Close()
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_mono_android_runtime_OutputStreamAdapter_n_1close(ptr noundef %env, ptr noundef %klass) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_close_0_5_60008df, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 5, i32 noundef 100665567, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_close_0_5_60008df)
	%cb2 = load ptr, ptr @native_cb_close_0_5_60008df, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	tail call void %fn(ptr noundef %env, ptr noundef %klass)
	ret void
}

; Method: System.Void Java.IO.OutputStream::n_Flush_mm_wrapper(System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Java.IO.OutputStream::Flush()
; Implemented: System.Void Android.Runtime.OutputStreamAdapter::Flush()
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_mono_android_runtime_OutputStreamAdapter_n_1flush(ptr noundef %env, ptr noundef %klass) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_flush_0_5_60008e0, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 5, i32 noundef 100665568, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_flush_0_5_60008e0)
	%cb2 = load ptr, ptr @native_cb_flush_0_5_60008e0, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	tail call void %fn(ptr noundef %env, ptr noundef %klass)
	ret void
}

; Method: System.Void Java.IO.OutputStream::n_Write_arrayB_mm_wrapper(System.IntPtr,System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Java.IO.OutputStream::Write(System.Byte[])
; Implemented: System.Void Android.Runtime.OutputStreamAdapter::Write(System.Byte[])
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_mono_android_runtime_OutputStreamAdapter_n_1write___3B(ptr noundef %env, ptr noundef %klass, ptr noundef %buffer) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_write_0_5_60008e1, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 5, i32 noundef 100665569, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_write_0_5_60008e1)
	%cb2 = load ptr, ptr @native_cb_write_0_5_60008e1, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	tail call void %fn(ptr noundef %env, ptr noundef %klass, ptr noundef %buffer)
	ret void
}

; Method: System.Void Java.IO.OutputStream::n_Write_arrayBII_mm_wrapper(System.IntPtr,System.IntPtr,System.IntPtr,System.Int32,System.Int32)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Java.IO.OutputStream::Write(System.Byte[],System.Int32,System.Int32)
; Implemented: System.Void Android.Runtime.OutputStreamAdapter::Write(System.Byte[],System.Int32,System.Int32)
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_mono_android_runtime_OutputStreamAdapter_n_1write___3BII(ptr noundef %env, ptr noundef %klass, ptr noundef %buffer, i32 noundef %offset, i32 noundef %length) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_write_0_5_60008e2, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 5, i32 noundef 100665570, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_write_0_5_60008e2)
	%cb2 = load ptr, ptr @native_cb_write_0_5_60008e2, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	tail call void %fn(ptr noundef %env, ptr noundef %klass, ptr noundef %buffer, i32 noundef %offset, i32 noundef %length)
	ret void
}

; Method: System.Void Java.IO.OutputStream::n_Write_I_mm_wrapper(System.IntPtr,System.IntPtr,System.Int32)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Java.IO.OutputStream::Write(System.Int32)
; Implemented: System.Void Android.Runtime.OutputStreamAdapter::Write(System.Int32)
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_mono_android_runtime_OutputStreamAdapter_n_1write__I(ptr noundef %env, ptr noundef %klass, i32 noundef %oneByte) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_write_0_5_60008e3, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 5, i32 noundef 100665571, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_write_0_5_60008e3)
	%cb2 = load ptr, ptr @native_cb_write_0_5_60008e3, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	tail call void %fn(ptr noundef %env, ptr noundef %klass, i32 noundef %oneByte)
	ret void
}

; Method: System.Void Java.Lang.IRunnableInvoker::n_Run_mm_wrapper(System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Java.Lang.IRunnable::Run()
; Implemented: System.Void Java.Lang.IRunnable::Run()
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_mono_java_lang_RunnableImplementor_n_1run(ptr noundef %env, ptr noundef %klass) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_run_0_6_6000b06, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 6, i32 noundef 100666118, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_run_0_6_6000b06)
	%cb2 = load ptr, ptr @native_cb_run_0_6_6000b06, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	tail call void %fn(ptr noundef %env, ptr noundef %klass)
	ret void
}

; Method: System.Void Android.Content.BroadcastReceiver::n_OnReceive_Landroid_content_Context_Landroid_content_Intent__mm_wrapper(System.IntPtr,System.IntPtr,System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Android.Content.BroadcastReceiver::OnReceive(Android.Content.Context,Android.Content.Intent)
; Implemented: System.Void wallpaperTrade.BootReceiver::OnReceive(Android.Content.Context,Android.Content.Intent)
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_crc640229306f97c153b1_BootReceiver_n_1onReceive__Landroid_content_Context_2Landroid_content_Intent_2(ptr noundef %env, ptr noundef %klass, ptr noundef %context, ptr noundef %intent) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_onReceive_0_7_60006cf, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 7, i32 noundef 100665039, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_onReceive_0_7_60006cf)
	%cb2 = load ptr, ptr @native_cb_onReceive_0_7_60006cf, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	tail call void %fn(ptr noundef %env, ptr noundef %klass, ptr noundef %context, ptr noundef %intent)
	ret void
}

; Method: System.Void Android.Content.BroadcastReceiver::n_OnReceive_Landroid_content_Context_Landroid_content_Intent__mm_wrapper(System.IntPtr,System.IntPtr,System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Android.Content.BroadcastReceiver::OnReceive(Android.Content.Context,Android.Content.Intent)
; Implemented: System.Void wallpaperTrade.ScreenReceiver::OnReceive(Android.Content.Context,Android.Content.Intent)
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_crc640229306f97c153b1_ScreenReceiver_n_1onReceive__Landroid_content_Context_2Landroid_content_Intent_2(ptr noundef %env, ptr noundef %klass, ptr noundef %context, ptr noundef %intent) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_onReceive_0_7_60006cf, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 7, i32 noundef 100665039, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_onReceive_0_7_60006cf)
	%cb2 = load ptr, ptr @native_cb_onReceive_0_7_60006cf, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	tail call void %fn(ptr noundef %env, ptr noundef %klass, ptr noundef %context, ptr noundef %intent)
	ret void
}

; Method: System.Void Android.App.Activity::n_OnCreate_Landroid_os_Bundle__mm_wrapper(System.IntPtr,System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Android.App.Activity::OnCreate(Android.OS.Bundle)
; Implemented: System.Void wallpaperTrade.MainActivity::OnCreate(Android.OS.Bundle)
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_crc640229306f97c153b1_MainActivity_n_1onCreate(ptr noundef %env, ptr noundef %klass, ptr noundef %savedInstanceState) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_onCreate_0_8_60007f4, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 8, i32 noundef 100665332, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_onCreate_0_8_60007f4)
	%cb2 = load ptr, ptr @native_cb_onCreate_0_8_60007f4, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	tail call void %fn(ptr noundef %env, ptr noundef %klass, ptr noundef %savedInstanceState)
	ret void
}

; Method: System.Void Android.App.Activity::n_OnResume_mm_wrapper(System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Android.App.Activity::OnResume()
; Implemented: System.Void wallpaperTrade.MainActivity::OnResume()
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_crc640229306f97c153b1_MainActivity_n_1onResume(ptr noundef %env, ptr noundef %klass) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_onResume_0_8_60007f5, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 8, i32 noundef 100665333, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_onResume_0_8_60007f5)
	%cb2 = load ptr, ptr @native_cb_onResume_0_8_60007f5, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	tail call void %fn(ptr noundef %env, ptr noundef %klass)
	ret void
}

; Method: System.Void Android.App.Activity::n_OnActivityResult_IILandroid_content_Intent__mm_wrapper(System.IntPtr,System.IntPtr,System.Int32,System.Int32,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Android.App.Activity::OnActivityResult(System.Int32,Android.App.Result,Android.Content.Intent)
; Implemented: System.Void wallpaperTrade.MainActivity::OnActivityResult(System.Int32,Android.App.Result,Android.Content.Intent)
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_crc640229306f97c153b1_MainActivity_n_1onActivityResult(ptr noundef %env, ptr noundef %klass, i32 noundef %requestCode, i32 noundef %resultCode, ptr noundef %data) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_onActivityResult_0_8_60007f6, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 8, i32 noundef 100665334, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_onActivityResult_0_8_60007f6)
	%cb2 = load ptr, ptr @native_cb_onActivityResult_0_8_60007f6, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	tail call void %fn(ptr noundef %env, ptr noundef %klass, i32 noundef %requestCode, i32 noundef %resultCode, ptr noundef %data)
	ret void
}

; Method: System.IntPtr Android.Views.View/IOnApplyWindowInsetsListenerInvoker::n_OnApplyWindowInsets_Landroid_view_View_Landroid_view_WindowInsets__mm_wrapper(System.IntPtr,System.IntPtr,System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: Android.Views.WindowInsets Android.Views.View/IOnApplyWindowInsetsListener::OnApplyWindowInsets(Android.Views.View,Android.Views.WindowInsets)
; Implemented: Android.Views.WindowInsets Android.Views.View/IOnApplyWindowInsetsListener::OnApplyWindowInsets(Android.Views.View,Android.Views.WindowInsets)
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define ptr @Java_crc640229306f97c153b1_MainActivity_1InsetsListener_n_1onApplyWindowInsets(ptr noundef %env, ptr noundef %klass, ptr noundef %0, ptr noundef %1) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_onApplyWindowInsets_0_9_6000379, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %2
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 9, i32 noundef 100664185, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_onApplyWindowInsets_0_9_6000379)
	%cb2 = load ptr, ptr @native_cb_onApplyWindowInsets_0_9_6000379, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %2
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %2]
	%3 = tail call noundef ptr %fn(ptr noundef %env, ptr noundef %klass, ptr noundef %0, ptr noundef %1)
	ret ptr %3
}

; Method: System.Void Android.App.Service::n_OnCreate_mm_wrapper(System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Android.App.Service::OnCreate()
; Implemented: System.Void wallpaperTrade.WallpaperMonitorService::OnCreate()
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_crc640229306f97c153b1_WallpaperMonitorService_n_1onCreate(ptr noundef %env, ptr noundef %klass) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_onCreate_0_10_600084d, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 10, i32 noundef 100665421, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_onCreate_0_10_600084d)
	%cb2 = load ptr, ptr @native_cb_onCreate_0_10_600084d, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	tail call void %fn(ptr noundef %env, ptr noundef %klass)
	ret void
}

; Method: System.Int32 Android.App.Service::n_OnStartCommand_Landroid_content_Intent_II_mm_wrapper(System.IntPtr,System.IntPtr,System.IntPtr,System.Int32,System.Int32)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: Android.App.StartCommandResult Android.App.Service::OnStartCommand(Android.Content.Intent,Android.App.StartCommandFlags,System.Int32)
; Implemented: Android.App.StartCommandResult wallpaperTrade.WallpaperMonitorService::OnStartCommand(Android.Content.Intent,Android.App.StartCommandFlags,System.Int32)
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define i32 @Java_crc640229306f97c153b1_WallpaperMonitorService_n_1onStartCommand(ptr noundef %env, ptr noundef %klass, ptr noundef %intent, i32 noundef %flags, i32 noundef %startId) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_onStartCommand_0_10_600084e, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 10, i32 noundef 100665422, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_onStartCommand_0_10_600084e)
	%cb2 = load ptr, ptr @native_cb_onStartCommand_0_10_600084e, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	%1 = tail call noundef i32 %fn(ptr noundef %env, ptr noundef %klass, ptr noundef %intent, i32 noundef %flags, i32 noundef %startId)
	ret i32 %1
}

; Method: System.Void Android.App.Service::n_OnDestroy_mm_wrapper(System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: System.Void Android.App.Service::OnDestroy()
; Implemented: System.Void wallpaperTrade.WallpaperMonitorService::OnDestroy()
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_crc640229306f97c153b1_WallpaperMonitorService_n_1onDestroy(ptr noundef %env, ptr noundef %klass) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_onDestroy_0_10_600084f, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 10, i32 noundef 100665423, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_onDestroy_0_10_600084f)
	%cb2 = load ptr, ptr @native_cb_onDestroy_0_10_600084f, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	tail call void %fn(ptr noundef %env, ptr noundef %klass)
	ret void
}

; Method: System.IntPtr Android.App.Service::n_OnBind_Landroid_content_Intent__mm_wrapper(System.IntPtr,System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: Android.OS.IBinder Android.App.Service::OnBind(Android.Content.Intent)
; Implemented: Android.OS.IBinder wallpaperTrade.WallpaperMonitorService::OnBind(Android.Content.Intent)
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define ptr @Java_crc640229306f97c153b1_WallpaperMonitorService_n_1onBind(ptr noundef %env, ptr noundef %klass, ptr noundef %intent) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_onBind_0_10_6000850, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 10, i32 noundef 100665424, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_onBind_0_10_6000850)
	%cb2 = load ptr, ptr @native_cb_onBind_0_10_6000850, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	%1 = tail call noundef ptr %fn(ptr noundef %env, ptr noundef %klass, ptr noundef %intent)
	ret ptr %1
}

; Method: System.Void Java.Interop.TypeManager/JavaTypeManager::n_Activate_mm(System.IntPtr,System.IntPtr,System.IntPtr,System.IntPtr,System.IntPtr,System.IntPtr)
; Assembly: Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065
; Registered: none
; Implemented: none
;
; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" uwtable
define void @Java_mono_android_TypeManager_n_1activate(ptr noundef %env, ptr noundef %klass, ptr noundef %jnienv, ptr noundef %jclass, ptr noundef %typename_ptr, ptr noundef %signature_ptr) local_unnamed_addr #3
{
	%cb1 = load ptr, ptr @native_cb_activate_0_11_6000bb1, align 8, !tbaa !3
	%isNull = icmp eq ptr %cb1, null
	br i1 %isNull, label %loadCallback, label %callbackLoaded

loadCallback: ; preds = %0
	%get_func_ptr = load ptr, ptr @get_function_pointer, align 8, !tbaa !3
	call void %get_func_ptr(i32 noundef 13, i32 noundef 11, i32 noundef 100666289, ptr nonnull noundef align(8) dereferenceable(8) @native_cb_activate_0_11_6000bb1)
	%cb2 = load ptr, ptr @native_cb_activate_0_11_6000bb1, align 8, !tbaa !3
	br label %callbackLoaded

callbackLoaded: ; preds = %loadCallback, %0
	%fn = phi ptr
		 [%cb2, %loadCallback],
		 [%cb1, %0]
	tail call void %fn(ptr noundef %env, ptr noundef %klass, ptr noundef %jnienv, ptr noundef %jclass, ptr noundef %typename_ptr, ptr noundef %signature_ptr)
	ret void
}

; Strings
@.mm.0 = private unnamed_addr constant [143 x i8] c"Android.Widget.CompoundButton/IOnCheckedChangeListenerInvoker, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065\00", align 16
@.mm.1 = private unnamed_addr constant [139 x i8] c"Android.Widget.RadioGroup/IOnCheckedChangeListenerInvoker, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065\00", align 16
@.mm.2 = private unnamed_addr constant [124 x i8] c"Android.Views.View/IOnClickListenerInvoker, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065\00", align 16
@.mm.3 = private unnamed_addr constant [101 x i8] c"Java.IO.InputStream, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065\00", align 16
@.mm.4 = private unnamed_addr constant [98 x i8] c"Java.Lang.Object, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065\00", align 16
@.mm.5 = private unnamed_addr constant [102 x i8] c"Java.IO.OutputStream, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065\00", align 16
@.mm.6 = private unnamed_addr constant [108 x i8] c"Java.Lang.IRunnableInvoker, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065\00", align 16
@.mm.7 = private unnamed_addr constant [115 x i8] c"Android.Content.BroadcastReceiver, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065\00", align 16
@.mm.8 = private unnamed_addr constant [102 x i8] c"Android.App.Activity, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065\00", align 16
@.mm.9 = private unnamed_addr constant [136 x i8] c"Android.Views.View/IOnApplyWindowInsetsListenerInvoker, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065\00", align 16
@.mm.10 = private unnamed_addr constant [101 x i8] c"Android.App.Service, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065\00", align 16
@.mm.11 = private unnamed_addr constant [122 x i8] c"Java.Interop.TypeManager/JavaTypeManager, Mono.Android, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065\00", align 16
@.mm.12 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 16

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [91 x i8] c"n_OnCheckedChanged_Landroid_widget_CompoundButton_Z_mm_wrapper(IntPtr,IntPtr,IntPtr,SByte)\00", align 16
@.MarshalMethodName.1_name = private unnamed_addr constant [87 x i8] c"n_OnCheckedChanged_Landroid_widget_RadioGroup_I_mm_wrapper(IntPtr,IntPtr,IntPtr,Int32)\00", align 16
@.MarshalMethodName.2_name = private unnamed_addr constant [63 x i8] c"n_OnClick_Landroid_view_View__mm_wrapper(IntPtr,IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.3_name = private unnamed_addr constant [34 x i8] c"n_Close_mm_wrapper(IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.4_name = private unnamed_addr constant [33 x i8] c"n_Read_mm_wrapper(IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.5_name = private unnamed_addr constant [47 x i8] c"n_Read_arrayB_mm_wrapper(IntPtr,IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.6_name = private unnamed_addr constant [61 x i8] c"n_Read_arrayBII_mm_wrapper(IntPtr,IntPtr,IntPtr,Int32,Int32)\00", align 16
@.MarshalMethodName.7_name = private unnamed_addr constant [61 x i8] c"n_Equals_Ljava_lang_Object__mm_wrapper(IntPtr,IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.8_name = private unnamed_addr constant [40 x i8] c"n_GetHashCode_mm_wrapper(IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.9_name = private unnamed_addr constant [37 x i8] c"n_ToString_mm_wrapper(IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.10_name = private unnamed_addr constant [34 x i8] c"n_Flush_mm_wrapper(IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.11_name = private unnamed_addr constant [48 x i8] c"n_Write_arrayB_mm_wrapper(IntPtr,IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.12_name = private unnamed_addr constant [62 x i8] c"n_Write_arrayBII_mm_wrapper(IntPtr,IntPtr,IntPtr,Int32,Int32)\00", align 16
@.MarshalMethodName.13_name = private unnamed_addr constant [42 x i8] c"n_Write_I_mm_wrapper(IntPtr,IntPtr,Int32)\00", align 16
@.MarshalMethodName.14_name = private unnamed_addr constant [32 x i8] c"n_Run_mm_wrapper(IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.15_name = private unnamed_addr constant [102 x i8] c"n_OnReceive_Landroid_content_Context_Landroid_content_Intent__mm_wrapper(IntPtr,IntPtr,IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.16_name = private unnamed_addr constant [64 x i8] c"n_OnCreate_Landroid_os_Bundle__mm_wrapper(IntPtr,IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.17_name = private unnamed_addr constant [37 x i8] c"n_OnResume_mm_wrapper(IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.18_name = private unnamed_addr constant [91 x i8] c"n_OnActivityResult_IILandroid_content_Intent__mm_wrapper(IntPtr,IntPtr,Int32,Int32,IntPtr)\00", align 16
@.MarshalMethodName.19_name = private unnamed_addr constant [109 x i8] c"n_OnApplyWindowInsets_Landroid_view_View_Landroid_view_WindowInsets__mm_wrapper(IntPtr,IntPtr,IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.20_name = private unnamed_addr constant [37 x i8] c"n_OnCreate_mm_wrapper(IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.21_name = private unnamed_addr constant [89 x i8] c"n_OnStartCommand_Landroid_content_Intent_II_mm_wrapper(IntPtr,IntPtr,IntPtr,Int32,Int32)\00", align 16
@.MarshalMethodName.22_name = private unnamed_addr constant [38 x i8] c"n_OnDestroy_mm_wrapper(IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.23_name = private unnamed_addr constant [67 x i8] c"n_OnBind_Landroid_content_Intent__mm_wrapper(IntPtr,IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.24_name = private unnamed_addr constant [57 x i8] c"n_Activate_mm(IntPtr,IntPtr,IntPtr,IntPtr,IntPtr,IntPtr)\00", align 16
@.MarshalMethodName.25_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" }
attributes #3 = { "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" uwtable }

; Metadata
!llvm.module.flags = !{!0, !1}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!".NET for Android remotes/origin/release/10.0.1xx @ d549e1dc4e2a083b08b4f24cb5495e81b99d79b5"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
