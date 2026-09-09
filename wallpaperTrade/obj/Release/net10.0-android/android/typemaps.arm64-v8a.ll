; ModuleID = 'typemaps.arm64-v8a.ll'
source_filename = "typemaps.arm64-v8a.ll"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-android21"

%struct.TypeMapJava = type {
	i32, ; uint32_t module_index
	i32, ; uint32_t type_token_id
	i32 ; uint32_t java_name_index
}

%struct.TypeMapModule = type {
	[16 x i8], ; uint8_t module_uuid[16]
	i32, ; uint32_t entry_count
	i32, ; uint32_t duplicate_count
	ptr, ; TypeMapModuleEntry map
	ptr, ; TypeMapModuleEntry duplicate_map
	ptr, ; char* assembly_name
	ptr, ; MonoImage image
	i32, ; uint32_t java_name_width
	ptr ; uint8_t java_map
}

%struct.TypeMapModuleEntry = type {
	i32, ; uint32_t type_token_id
	i32 ; uint32_t java_map_index
}

@map_module_count = dso_local local_unnamed_addr constant i32 3, align 4

@java_type_count = dso_local local_unnamed_addr constant i32 147, align 4

; Managed modules map
@map_modules = dso_local local_unnamed_addr global [3 x %struct.TypeMapModule] [
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x6f, i8 u0xac, i8 u0xc0, i8 u0x54, i8 u0x42, i8 u0x8c, i8 u0x7c, i8 u0x49, i8 u0x89, i8 u0x04, i8 u0xd1, i8 u0xba, i8 u0x92, i8 u0xb0, i8 u0x83, i8 u0xe4 ], ; module_uuid: 54c0ac6f-8c42-497c-8904-d1ba92b083e4
		i32 14, ; uint32_t entry_count
		i32 2, ; uint32_t duplicate_count
		ptr @module0_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module0_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.0_assembly_name, ; assembly_name: Java.Interop
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 0
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x80, i8 u0xad, i8 u0xaa, i8 u0x99, i8 u0xc8, i8 u0xba, i8 u0xfd, i8 u0x46, i8 u0xb3, i8 u0x46, i8 u0xeb, i8 u0x15, i8 u0xe2, i8 u0x9f, i8 u0xd2, i8 u0x52 ], ; module_uuid: 99aaad80-bac8-46fd-b346-eb15e29fd252
		i32 130, ; uint32_t entry_count
		i32 38, ; uint32_t duplicate_count
		ptr @module1_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module1_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.1_assembly_name, ; assembly_name: Mono.Android
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 1
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xe5, i8 u0x50, i8 u0x9a, i8 u0x9d, i8 u0x8a, i8 u0x4a, i8 u0x7d, i8 u0x41, i8 u0x95, i8 u0x19, i8 u0x74, i8 u0x1f, i8 u0x97, i8 u0x01, i8 u0x55, i8 u0x49 ], ; module_uuid: 9d9a50e5-4a8a-417d-9519-741f97015549
		i32 5, ; uint32_t entry_count
		i32 0, ; uint32_t duplicate_count
		ptr @module2_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.2_assembly_name, ; assembly_name: wallpaperTrade
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	} ; 2
], align 8

; Java types name hashes
@map_java_hashes = dso_local local_unnamed_addr constant [147 x i64] [
	i64 u0x01cd624f1e38cc9f, ; 0 => java/lang/Byte
	i64 u0x02e426fc27cd6822, ; 1 => android/provider/MediaStore$Images$Media
	i64 u0x0304e457b1d15194, ; 2 => android/view/ViewGroup$MarginLayoutParams
	i64 u0x07cd9c52070fe91d, ; 3 => android/widget/GridLayout$LayoutParams
	i64 u0x0b1da699fb29019a, ; 4 => android/os/BaseBundle
	i64 u0x0c44130caa233945, ; 5 => mono/android/runtime/JavaObject
	i64 u0x0d9335f0988cd796, ; 6 => java/util/HashMap
	i64 u0x10cc64dc53558d33, ; 7 => android/content/ComponentName
	i64 u0x1614b7d0dd50c56b, ; 8 => android/view/View$OnApplyWindowInsetsListener
	i64 u0x16b07129ee36476e, ; 9 => android/os/PowerManager
	i64 u0x194b32fbae047fc7, ; 10 => net/dot/jni/internal/JavaProxyObject
	i64 u0x1e04bf19f9c14045, ; 11 => android/util/AttributeSet
	i64 u0x1e69018626ef9ffb, ; 12 => android/os/Handler
	i64 u0x1eef7492beaf81e2, ; 13 => android/os/IInterface
	i64 u0x22436d73eb9797a7, ; 14 => android/content/IntentFilter
	i64 u0x225c20a45cb91cd7, ; 15 => java/lang/Error
	i64 u0x2eacb325830db74c, ; 16 => android/database/ContentObserver
	i64 u0x321c29cf8c6f7a93, ; 17 => android/content/res/Resources
	i64 u0x32d6a1d6ee9f6d5a, ; 18 => android/content/Intent
	i64 u0x332031975eda7654, ; 19 => java/lang/Boolean
	i64 u0x35e989807a64bcd9, ; 20 => java/lang/IllegalStateException
	i64 u0x3611feb7c92af67a, ; 21 => android/content/SharedPreferences$Editor
	i64 u0x39f1c81500ddb55b, ; 22 => [F
	i64 u0x3b680a1a45b10f7b, ; 23 => mono/android/widget/RadioGroup_OnCheckedChangeListenerImplementor
	i64 u0x406e54c64b3bee74, ; 24 => android/runtime/JavaProxyThrowable
	i64 u0x408444a4435b4e94, ; 25 => crc640229306f97c153b1/ScreenReceiver
	i64 u0x40c05cff47992547, ; 26 => android/view/ViewGroup
	i64 u0x418a18fba47ed847, ; 27 => android/os/PowerManager$WakeLock
	i64 u0x42e91d1f598314ca, ; 28 => android/database/DataSetObserver
	i64 u0x4768ffd64bb01691, ; 29 => android/view/WindowInsets$Type
	i64 u0x4930daf7c10ff422, ; 30 => android/app/Notification$Builder
	i64 u0x4f858ea9c9162f43, ; 31 => android/os/IBinder
	i64 u0x516bd5763f07d608, ; 32 => android/net/Uri
	i64 u0x5181b129b1a25949, ; 33 => java/lang/Class
	i64 u0x5238ad63b58da994, ; 34 => java/lang/ClassCastException
	i64 u0x525031aa556acae7, ; 35 => android/widget/ImageView$ScaleType
	i64 u0x529da4201fa0d461, ; 36 => net/dot/jni/internal/JavaProxyThrowable
	i64 u0x53ead18b9df3fcb2, ; 37 => android/os/IBinder$FrozenStateChangeCallback
	i64 u0x543ee7a3edd80785, ; 38 => android/app/Notification
	i64 u0x54c5d3387059fe2c, ; 39 => mono/android/view/View_OnClickListenerImplementor
	i64 u0x551ac881eb4466c0, ; 40 => java/lang/Number
	i64 u0x560a92597b121e00, ; 41 => [C
	i64 u0x56365290d5a06704, ; 42 => java/lang/LinkageError
	i64 u0x57e37830b49b24af, ; 43 => android/app/NotificationChannel
	i64 u0x57fe4a40460344db, ; 44 => android/os/Build$VERSION
	i64 u0x5a6af884fe3c181e, ; 45 => android/os/Bundle
	i64 u0x5b905726d9bc975f, ; 46 => android/widget/TextView
	i64 u0x5bfd65ae1a6e6ffc, ; 47 => android/app/Activity
	i64 u0x5e38b925960b7be9, ; 48 => android/graphics/Rect
	i64 u0x5f5a9fc3430795a4, ; 49 => android/content/ContextWrapper
	i64 u0x5f7e709faf8646e0, ; 50 => java/lang/Short
	i64 u0x61428f9f249ac534, ; 51 => [Z
	i64 u0x62daf35c931c09d6, ; 52 => android/content/BroadcastReceiver
	i64 u0x65f6b14b7e978927, ; 53 => java/io/IOException
	i64 u0x6dbd68e69d357c68, ; 54 => android/app/WallpaperManager
	i64 u0x6e0fb15bd0f04d15, ; 55 => java/lang/StackTraceElement
	i64 u0x70a08622aaf16a57, ; 56 => android/provider/MediaStore$Images
	i64 u0x720cd712e1248c34, ; 57 => java/util/Iterator
	i64 u0x75591c18ddf5e52d, ; 58 => mono/android/TypeManager
	i64 u0x76cbd2104dd555ed, ; 59 => android/content/Context
	i64 u0x7923685decfc70fb, ; 60 => mono/android/widget/CompoundButton_OnCheckedChangeListenerImplementor
	i64 u0x7b90c42bde036cae, ; 61 => [I
	i64 u0x7b925bdca68a0101, ; 62 => java/util/ArrayList
	i64 u0x7e201ad40955df46, ; 63 => android/os/Parcel
	i64 u0x83314b5931a387fb, ; 64 => android/widget/Toast
	i64 u0x84f94178aab6cc34, ; 65 => java/lang/CharSequence
	i64 u0x852b5457ebdd5c87, ; 66 => android/view/ViewGroup$LayoutParams
	i64 u0x888700b03d541d93, ; 67 => java/lang/RuntimeException
	i64 u0x88f7510c649f4a97, ; 68 => java/io/InputStream
	i64 u0x8a3ea3c274e8ce68, ; 69 => java/lang/Character
	i64 u0x8cc2a9a0a7b93429, ; 70 => crc640229306f97c153b1/BootReceiver
	i64 u0x90b4aeb45636cd6a, ; 71 => mono/android/runtime/OutputStreamAdapter
	i64 u0x92188d393e2af2d2, ; 72 => java/lang/Throwable
	i64 u0x92b59c839bc46278, ; 73 => java/lang/Thread
	i64 u0x965bfaf1ff1da014, ; 74 => java/lang/ReflectiveOperationException
	i64 u0x98ba110c6c57da31, ; 75 => java/lang/Float
	i64 u0x995f02becc4146fe, ; 76 => android/content/ClipData
	i64 u0x99df91bab800c287, ; 77 => mono/android/runtime/InputStreamAdapter
	i64 u0x9a23c2d41060f81e, ; 78 => java/io/File
	i64 u0x9a68fa465ca8abf9, ; 79 => java/io/FileDescriptor
	i64 u0x9cebbb039a638f4d, ; 80 => android/graphics/BitmapFactory$Options
	i64 u0x9e10a0b3efa170dc, ; 81 => android/view/ContextThemeWrapper
	i64 u0x9fa1370a1b1093fa, ; 82 => java/lang/NullPointerException
	i64 u0xa865adbdd81d9951, ; 83 => java/io/OutputStream
	i64 u0xa86f66387eaee170, ; 84 => android/content/SharedPreferences
	i64 u0xabc3cd0f40f748aa, ; 85 => java/lang/String
	i64 u0xac7bbd754d805e27, ; 86 => android/graphics/BitmapFactory
	i64 u0xac9902bb0e4c5217, ; 87 => java/lang/IllegalArgumentException
	i64 u0xacaf4fe23af1f72a, ; 88 => [S
	i64 u0xada6872f699d2ae8, ; 89 => [J
	i64 u0xb02badeb1c97535c, ; 90 => java/lang/Integer
	i64 u0xb18d71343ca8e96f, ; 91 => java/lang/Exception
	i64 u0xb2aba88e268148a7, ; 92 => crc640229306f97c153b1/MainActivity_InsetsListener
	i64 u0xb56e3efa284790aa, ; 93 => android/view/WindowInsets
	i64 u0xb678d42a79a70cc7, ; 94 => android/widget/GridLayout$Spec
	i64 u0xb6c4749da9477c3a, ; 95 => [B
	i64 u0xb77aae9e2e13bfcc, ; 96 => android/app/Service
	i64 u0xb8df224d6b778ca3, ; 97 => android/view/View
	i64 u0xbac16081fceb204f, ; 98 => android/content/BroadcastReceiver$PendingResult
	i64 u0xbb41c32523812652, ; 99 => android/widget/Button
	i64 u0xbb84ccbe48f6c18b, ; 100 => android/os/Looper
	i64 u0xbf297df5b4a127d7, ; 101 => crc640229306f97c153b1/WallpaperMonitorService
	i64 u0xbf6d427143271cb3, ; 102 => java/lang/Object
	i64 u0xbf9dae2beff68075, ; 103 => android/graphics/Insets
	i64 u0xc00f4c2f11efdcff, ; 104 => java/lang/ClassNotFoundException
	i64 u0xc0de8660ee302209, ; 105 => crc640229306f97c153b1/MainActivity
	i64 u0xc1a43ce814bd6203, ; 106 => android/content/ClipData$Item
	i64 u0xc1a807325c15cf73, ; 107 => android/graphics/Bitmap
	i64 u0xc2a8e50a5f08afc6, ; 108 => mono/java/lang/RunnableImplementor
	i64 u0xc3eb0cbb47f178b9, ; 109 => java/lang/Enum
	i64 u0xc4e1d7e4d6990b04, ; 110 => android/database/Cursor
	i64 u0xc63933355b4d467d, ; 111 => android/widget/CompoundButton
	i64 u0xc8f2825964e96acd, ; 112 => android/widget/RadioGroup
	i64 u0xca35caf567cfa745, ; 113 => java/util/Collection
	i64 u0xca754b77efc8606b, ; 114 => android/app/NotificationManager
	i64 u0xcabf871ef950ad91, ; 115 => android/view/View$OnClickListener
	i64 u0xcc306823503920e9, ; 116 => android/app/Application
	i64 u0xd1b288a9c7bb8f53, ; 117 => java/lang/Double
	i64 u0xd1c9e6860a723f11, ; 118 => android/widget/GridLayout
	i64 u0xd291ecb38b9c7330, ; 119 => android/widget/RadioGroup$OnCheckedChangeListener
	i64 u0xd2fc750314fd2213, ; 120 => [D
	i64 u0xd5a28b8fa6d48e71, ; 121 => android/os/Build
	i64 u0xd7bf0ca2c70de05c, ; 122 => android/util/DisplayMetrics
	i64 u0xdbb76cb30e7b6509, ; 123 => android/content/ContentResolver
	i64 u0xdd812f1d4afa427b, ; 124 => java/lang/UnsupportedOperationException
	i64 u0xdfabd9351f4351a6, ; 125 => [Ljava/lang/Object;
	i64 u0xe024b538ad65ea66, ; 126 => java/util/function/Consumer
	i64 u0xe0446bf91fb0c2dd, ; 127 => java/lang/NoClassDefFoundError
	i64 u0xe1b3c5871398eb28, ; 128 => java/nio/channels/FileChannel
	i64 u0xe38528954b158fff, ; 129 => java/util/concurrent/Executor
	i64 u0xe50fb4f0adb1330f, ; 130 => android/widget/ImageView
	i64 u0xe5abbaa9de37d34b, ; 131 => net/dot/jni/ManagedPeer
	i64 u0xe663c278c572f570, ; 132 => android/database/CharArrayBuffer
	i64 u0xeb82145dcac4c559, ; 133 => java/lang/Long
	i64 u0xed3bf28f37177c87, ; 134 => android/content/SharedPreferences$OnSharedPreferenceChangeListener
	i64 u0xed49ed70aa9be1b3, ; 135 => java/nio/channels/spi/AbstractInterruptibleChannel
	i64 u0xef2f2996a1d369cc, ; 136 => java/io/FileInputStream
	i64 u0xefd8c7aa4b48418e, ; 137 => android/widget/LinearLayout
	i64 u0xf0654f9be531078e, ; 138 => java/io/Closeable
	i64 u0xf11f22a6441fcfbc, ; 139 => java/lang/IndexOutOfBoundsException
	i64 u0xf2e3de579e508658, ; 140 => android/provider/MediaStore
	i64 u0xfaa2c879d63dad6e, ; 141 => android/widget/Switch
	i64 u0xfbe9bfa5cc50fed6, ; 142 => java/util/HashSet
	i64 u0xfd2b1a3de667eb51, ; 143 => java/lang/Runnable
	i64 u0xfd45cc49d3236300, ; 144 => android/os/IBinder$DeathRecipient
	i64 u0xfe07df0b35277433, ; 145 => android/widget/LinearLayout$LayoutParams
	i64 u0xfff33782bdf2bde2 ; 146 => android/widget/CompoundButton$OnCheckedChangeListener
], align 8

@module0_managed_to_java = internal dso_local constant [14 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000006, ; uint32_t type_token_id
		i32 125; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200000a, ; uint32_t type_token_id
		i32 72; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200000b, ; uint32_t type_token_id
		i32 102; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200002a, ; uint32_t type_token_id
		i32 51; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x0200002d, ; uint32_t type_token_id
		i32 95; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000030, ; uint32_t type_token_id
		i32 41; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000033, ; uint32_t type_token_id
		i32 88; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000036, ; uint32_t type_token_id
		i32 61; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000039, ; uint32_t type_token_id
		i32 89; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x0200003c, ; uint32_t type_token_id
		i32 22; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x0200003f, ; uint32_t type_token_id
		i32 120; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x02000042, ; uint32_t type_token_id
		i32 10; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x02000043, ; uint32_t type_token_id
		i32 36; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x02000089, ; uint32_t type_token_id
		i32 131; uint32_t java_map_index
	} ; 13
], align 4

@module0_managed_to_java_duplicates = internal dso_local constant [2 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000009, ; uint32_t type_token_id
		i32 125; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200000c, ; uint32_t type_token_id
		i32 125; uint32_t java_map_index
	} ; 1
], align 4

@module1_managed_to_java = internal dso_local constant [130 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000055, ; uint32_t type_token_id
		i32 140; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000056, ; uint32_t type_token_id
		i32 56; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000057, ; uint32_t type_token_id
		i32 1; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000058, ; uint32_t type_token_id
		i32 132; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000059, ; uint32_t type_token_id
		i32 16; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x0200005b, ; uint32_t type_token_id
		i32 28; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x0200005e, ; uint32_t type_token_id
		i32 110; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000060, ; uint32_t type_token_id
		i32 46; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000061, ; uint32_t type_token_id
		i32 99; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x02000062, ; uint32_t type_token_id
		i32 111; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x02000063, ; uint32_t type_token_id
		i32 146; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x02000066, ; uint32_t type_token_id
		i32 60; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x0200006b, ; uint32_t type_token_id
		i32 118; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x0200006c, ; uint32_t type_token_id
		i32 3; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x0200006d, ; uint32_t type_token_id
		i32 94; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x0200006e, ; uint32_t type_token_id
		i32 130; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x0200006f, ; uint32_t type_token_id
		i32 35; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x02000070, ; uint32_t type_token_id
		i32 137; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x02000071, ; uint32_t type_token_id
		i32 145; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x02000073, ; uint32_t type_token_id
		i32 112; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x02000074, ; uint32_t type_token_id
		i32 119; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x02000077, ; uint32_t type_token_id
		i32 23; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x0200007b, ; uint32_t type_token_id
		i32 141; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x0200007c, ; uint32_t type_token_id
		i32 64; uint32_t java_map_index
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 u0x0200007e, ; uint32_t type_token_id
		i32 122; uint32_t java_map_index
	}, ; 24
	%struct.TypeMapModuleEntry {
		i32 u0x0200007f, ; uint32_t type_token_id
		i32 11; uint32_t java_map_index
	}, ; 25
	%struct.TypeMapModuleEntry {
		i32 u0x02000081, ; uint32_t type_token_id
		i32 12; uint32_t java_map_index
	}, ; 26
	%struct.TypeMapModuleEntry {
		i32 u0x02000082, ; uint32_t type_token_id
		i32 9; uint32_t java_map_index
	}, ; 27
	%struct.TypeMapModuleEntry {
		i32 u0x02000083, ; uint32_t type_token_id
		i32 27; uint32_t java_map_index
	}, ; 28
	%struct.TypeMapModuleEntry {
		i32 u0x02000084, ; uint32_t type_token_id
		i32 4; uint32_t java_map_index
	}, ; 29
	%struct.TypeMapModuleEntry {
		i32 u0x02000085, ; uint32_t type_token_id
		i32 121; uint32_t java_map_index
	}, ; 30
	%struct.TypeMapModuleEntry {
		i32 u0x02000086, ; uint32_t type_token_id
		i32 44; uint32_t java_map_index
	}, ; 31
	%struct.TypeMapModuleEntry {
		i32 u0x02000088, ; uint32_t type_token_id
		i32 45; uint32_t java_map_index
	}, ; 32
	%struct.TypeMapModuleEntry {
		i32 u0x02000089, ; uint32_t type_token_id
		i32 144; uint32_t java_map_index
	}, ; 33
	%struct.TypeMapModuleEntry {
		i32 u0x0200008b, ; uint32_t type_token_id
		i32 31; uint32_t java_map_index
	}, ; 34
	%struct.TypeMapModuleEntry {
		i32 u0x0200008c, ; uint32_t type_token_id
		i32 37; uint32_t java_map_index
	}, ; 35
	%struct.TypeMapModuleEntry {
		i32 u0x0200008f, ; uint32_t type_token_id
		i32 13; uint32_t java_map_index
	}, ; 36
	%struct.TypeMapModuleEntry {
		i32 u0x02000091, ; uint32_t type_token_id
		i32 100; uint32_t java_map_index
	}, ; 37
	%struct.TypeMapModuleEntry {
		i32 u0x02000092, ; uint32_t type_token_id
		i32 63; uint32_t java_map_index
	}, ; 38
	%struct.TypeMapModuleEntry {
		i32 u0x02000095, ; uint32_t type_token_id
		i32 97; uint32_t java_map_index
	}, ; 39
	%struct.TypeMapModuleEntry {
		i32 u0x02000096, ; uint32_t type_token_id
		i32 8; uint32_t java_map_index
	}, ; 40
	%struct.TypeMapModuleEntry {
		i32 u0x02000098, ; uint32_t type_token_id
		i32 115; uint32_t java_map_index
	}, ; 41
	%struct.TypeMapModuleEntry {
		i32 u0x0200009a, ; uint32_t type_token_id
		i32 39; uint32_t java_map_index
	}, ; 42
	%struct.TypeMapModuleEntry {
		i32 u0x0200009e, ; uint32_t type_token_id
		i32 81; uint32_t java_map_index
	}, ; 43
	%struct.TypeMapModuleEntry {
		i32 u0x0200009f, ; uint32_t type_token_id
		i32 26; uint32_t java_map_index
	}, ; 44
	%struct.TypeMapModuleEntry {
		i32 u0x020000a0, ; uint32_t type_token_id
		i32 66; uint32_t java_map_index
	}, ; 45
	%struct.TypeMapModuleEntry {
		i32 u0x020000a1, ; uint32_t type_token_id
		i32 2; uint32_t java_map_index
	}, ; 46
	%struct.TypeMapModuleEntry {
		i32 u0x020000a3, ; uint32_t type_token_id
		i32 93; uint32_t java_map_index
	}, ; 47
	%struct.TypeMapModuleEntry {
		i32 u0x020000a4, ; uint32_t type_token_id
		i32 29; uint32_t java_map_index
	}, ; 48
	%struct.TypeMapModuleEntry {
		i32 u0x020000b9, ; uint32_t type_token_id
		i32 77; uint32_t java_map_index
	}, ; 49
	%struct.TypeMapModuleEntry {
		i32 u0x020000bb, ; uint32_t type_token_id
		i32 113; uint32_t java_map_index
	}, ; 50
	%struct.TypeMapModuleEntry {
		i32 u0x020000bd, ; uint32_t type_token_id
		i32 6; uint32_t java_map_index
	}, ; 51
	%struct.TypeMapModuleEntry {
		i32 u0x020000c6, ; uint32_t type_token_id
		i32 62; uint32_t java_map_index
	}, ; 52
	%struct.TypeMapModuleEntry {
		i32 u0x020000c8, ; uint32_t type_token_id
		i32 5; uint32_t java_map_index
	}, ; 53
	%struct.TypeMapModuleEntry {
		i32 u0x020000c9, ; uint32_t type_token_id
		i32 24; uint32_t java_map_index
	}, ; 54
	%struct.TypeMapModuleEntry {
		i32 u0x020000ca, ; uint32_t type_token_id
		i32 142; uint32_t java_map_index
	}, ; 55
	%struct.TypeMapModuleEntry {
		i32 u0x020000d6, ; uint32_t type_token_id
		i32 71; uint32_t java_map_index
	}, ; 56
	%struct.TypeMapModuleEntry {
		i32 u0x020000de, ; uint32_t type_token_id
		i32 32; uint32_t java_map_index
	}, ; 57
	%struct.TypeMapModuleEntry {
		i32 u0x020000e0, ; uint32_t type_token_id
		i32 107; uint32_t java_map_index
	}, ; 58
	%struct.TypeMapModuleEntry {
		i32 u0x020000e1, ; uint32_t type_token_id
		i32 86; uint32_t java_map_index
	}, ; 59
	%struct.TypeMapModuleEntry {
		i32 u0x020000e2, ; uint32_t type_token_id
		i32 80; uint32_t java_map_index
	}, ; 60
	%struct.TypeMapModuleEntry {
		i32 u0x020000e3, ; uint32_t type_token_id
		i32 103; uint32_t java_map_index
	}, ; 61
	%struct.TypeMapModuleEntry {
		i32 u0x020000e4, ; uint32_t type_token_id
		i32 48; uint32_t java_map_index
	}, ; 62
	%struct.TypeMapModuleEntry {
		i32 u0x020000e6, ; uint32_t type_token_id
		i32 59; uint32_t java_map_index
	}, ; 63
	%struct.TypeMapModuleEntry {
		i32 u0x020000e7, ; uint32_t type_token_id
		i32 18; uint32_t java_map_index
	}, ; 64
	%struct.TypeMapModuleEntry {
		i32 u0x020000e9, ; uint32_t type_token_id
		i32 52; uint32_t java_map_index
	}, ; 65
	%struct.TypeMapModuleEntry {
		i32 u0x020000ea, ; uint32_t type_token_id
		i32 98; uint32_t java_map_index
	}, ; 66
	%struct.TypeMapModuleEntry {
		i32 u0x020000ec, ; uint32_t type_token_id
		i32 76; uint32_t java_map_index
	}, ; 67
	%struct.TypeMapModuleEntry {
		i32 u0x020000ed, ; uint32_t type_token_id
		i32 106; uint32_t java_map_index
	}, ; 68
	%struct.TypeMapModuleEntry {
		i32 u0x020000ee, ; uint32_t type_token_id
		i32 7; uint32_t java_map_index
	}, ; 69
	%struct.TypeMapModuleEntry {
		i32 u0x020000ef, ; uint32_t type_token_id
		i32 123; uint32_t java_map_index
	}, ; 70
	%struct.TypeMapModuleEntry {
		i32 u0x020000f2, ; uint32_t type_token_id
		i32 49; uint32_t java_map_index
	}, ; 71
	%struct.TypeMapModuleEntry {
		i32 u0x020000f4, ; uint32_t type_token_id
		i32 14; uint32_t java_map_index
	}, ; 72
	%struct.TypeMapModuleEntry {
		i32 u0x020000f5, ; uint32_t type_token_id
		i32 21; uint32_t java_map_index
	}, ; 73
	%struct.TypeMapModuleEntry {
		i32 u0x020000f7, ; uint32_t type_token_id
		i32 134; uint32_t java_map_index
	}, ; 74
	%struct.TypeMapModuleEntry {
		i32 u0x020000f9, ; uint32_t type_token_id
		i32 84; uint32_t java_map_index
	}, ; 75
	%struct.TypeMapModuleEntry {
		i32 u0x020000fc, ; uint32_t type_token_id
		i32 17; uint32_t java_map_index
	}, ; 76
	%struct.TypeMapModuleEntry {
		i32 u0x02000102, ; uint32_t type_token_id
		i32 47; uint32_t java_map_index
	}, ; 77
	%struct.TypeMapModuleEntry {
		i32 u0x02000103, ; uint32_t type_token_id
		i32 116; uint32_t java_map_index
	}, ; 78
	%struct.TypeMapModuleEntry {
		i32 u0x02000104, ; uint32_t type_token_id
		i32 38; uint32_t java_map_index
	}, ; 79
	%struct.TypeMapModuleEntry {
		i32 u0x02000105, ; uint32_t type_token_id
		i32 30; uint32_t java_map_index
	}, ; 80
	%struct.TypeMapModuleEntry {
		i32 u0x02000106, ; uint32_t type_token_id
		i32 114; uint32_t java_map_index
	}, ; 81
	%struct.TypeMapModuleEntry {
		i32 u0x0200010a, ; uint32_t type_token_id
		i32 43; uint32_t java_map_index
	}, ; 82
	%struct.TypeMapModuleEntry {
		i32 u0x0200010d, ; uint32_t type_token_id
		i32 96; uint32_t java_map_index
	}, ; 83
	%struct.TypeMapModuleEntry {
		i32 u0x02000111, ; uint32_t type_token_id
		i32 54; uint32_t java_map_index
	}, ; 84
	%struct.TypeMapModuleEntry {
		i32 u0x02000113, ; uint32_t type_token_id
		i32 128; uint32_t java_map_index
	}, ; 85
	%struct.TypeMapModuleEntry {
		i32 u0x02000115, ; uint32_t type_token_id
		i32 135; uint32_t java_map_index
	}, ; 86
	%struct.TypeMapModuleEntry {
		i32 u0x02000117, ; uint32_t type_token_id
		i32 78; uint32_t java_map_index
	}, ; 87
	%struct.TypeMapModuleEntry {
		i32 u0x02000118, ; uint32_t type_token_id
		i32 79; uint32_t java_map_index
	}, ; 88
	%struct.TypeMapModuleEntry {
		i32 u0x02000119, ; uint32_t type_token_id
		i32 136; uint32_t java_map_index
	}, ; 89
	%struct.TypeMapModuleEntry {
		i32 u0x0200011a, ; uint32_t type_token_id
		i32 138; uint32_t java_map_index
	}, ; 90
	%struct.TypeMapModuleEntry {
		i32 u0x0200011c, ; uint32_t type_token_id
		i32 68; uint32_t java_map_index
	}, ; 91
	%struct.TypeMapModuleEntry {
		i32 u0x0200011e, ; uint32_t type_token_id
		i32 53; uint32_t java_map_index
	}, ; 92
	%struct.TypeMapModuleEntry {
		i32 u0x0200011f, ; uint32_t type_token_id
		i32 83; uint32_t java_map_index
	}, ; 93
	%struct.TypeMapModuleEntry {
		i32 u0x02000121, ; uint32_t type_token_id
		i32 57; uint32_t java_map_index
	}, ; 94
	%struct.TypeMapModuleEntry {
		i32 u0x02000123, ; uint32_t type_token_id
		i32 126; uint32_t java_map_index
	}, ; 95
	%struct.TypeMapModuleEntry {
		i32 u0x02000125, ; uint32_t type_token_id
		i32 129; uint32_t java_map_index
	}, ; 96
	%struct.TypeMapModuleEntry {
		i32 u0x02000127, ; uint32_t type_token_id
		i32 19; uint32_t java_map_index
	}, ; 97
	%struct.TypeMapModuleEntry {
		i32 u0x02000128, ; uint32_t type_token_id
		i32 0; uint32_t java_map_index
	}, ; 98
	%struct.TypeMapModuleEntry {
		i32 u0x02000129, ; uint32_t type_token_id
		i32 69; uint32_t java_map_index
	}, ; 99
	%struct.TypeMapModuleEntry {
		i32 u0x0200012a, ; uint32_t type_token_id
		i32 33; uint32_t java_map_index
	}, ; 100
	%struct.TypeMapModuleEntry {
		i32 u0x0200012b, ; uint32_t type_token_id
		i32 104; uint32_t java_map_index
	}, ; 101
	%struct.TypeMapModuleEntry {
		i32 u0x0200012c, ; uint32_t type_token_id
		i32 117; uint32_t java_map_index
	}, ; 102
	%struct.TypeMapModuleEntry {
		i32 u0x0200012d, ; uint32_t type_token_id
		i32 91; uint32_t java_map_index
	}, ; 103
	%struct.TypeMapModuleEntry {
		i32 u0x0200012e, ; uint32_t type_token_id
		i32 75; uint32_t java_map_index
	}, ; 104
	%struct.TypeMapModuleEntry {
		i32 u0x0200012f, ; uint32_t type_token_id
		i32 65; uint32_t java_map_index
	}, ; 105
	%struct.TypeMapModuleEntry {
		i32 u0x02000130, ; uint32_t type_token_id
		i32 90; uint32_t java_map_index
	}, ; 106
	%struct.TypeMapModuleEntry {
		i32 u0x02000131, ; uint32_t type_token_id
		i32 133; uint32_t java_map_index
	}, ; 107
	%struct.TypeMapModuleEntry {
		i32 u0x02000132, ; uint32_t type_token_id
		i32 102; uint32_t java_map_index
	}, ; 108
	%struct.TypeMapModuleEntry {
		i32 u0x02000133, ; uint32_t type_token_id
		i32 67; uint32_t java_map_index
	}, ; 109
	%struct.TypeMapModuleEntry {
		i32 u0x02000134, ; uint32_t type_token_id
		i32 50; uint32_t java_map_index
	}, ; 110
	%struct.TypeMapModuleEntry {
		i32 u0x02000135, ; uint32_t type_token_id
		i32 85; uint32_t java_map_index
	}, ; 111
	%struct.TypeMapModuleEntry {
		i32 u0x02000137, ; uint32_t type_token_id
		i32 73; uint32_t java_map_index
	}, ; 112
	%struct.TypeMapModuleEntry {
		i32 u0x02000138, ; uint32_t type_token_id
		i32 108; uint32_t java_map_index
	}, ; 113
	%struct.TypeMapModuleEntry {
		i32 u0x02000139, ; uint32_t type_token_id
		i32 72; uint32_t java_map_index
	}, ; 114
	%struct.TypeMapModuleEntry {
		i32 u0x0200013a, ; uint32_t type_token_id
		i32 34; uint32_t java_map_index
	}, ; 115
	%struct.TypeMapModuleEntry {
		i32 u0x0200013b, ; uint32_t type_token_id
		i32 109; uint32_t java_map_index
	}, ; 116
	%struct.TypeMapModuleEntry {
		i32 u0x0200013d, ; uint32_t type_token_id
		i32 15; uint32_t java_map_index
	}, ; 117
	%struct.TypeMapModuleEntry {
		i32 u0x02000140, ; uint32_t type_token_id
		i32 87; uint32_t java_map_index
	}, ; 118
	%struct.TypeMapModuleEntry {
		i32 u0x02000141, ; uint32_t type_token_id
		i32 20; uint32_t java_map_index
	}, ; 119
	%struct.TypeMapModuleEntry {
		i32 u0x02000142, ; uint32_t type_token_id
		i32 139; uint32_t java_map_index
	}, ; 120
	%struct.TypeMapModuleEntry {
		i32 u0x02000143, ; uint32_t type_token_id
		i32 143; uint32_t java_map_index
	}, ; 121
	%struct.TypeMapModuleEntry {
		i32 u0x02000145, ; uint32_t type_token_id
		i32 42; uint32_t java_map_index
	}, ; 122
	%struct.TypeMapModuleEntry {
		i32 u0x02000146, ; uint32_t type_token_id
		i32 127; uint32_t java_map_index
	}, ; 123
	%struct.TypeMapModuleEntry {
		i32 u0x02000147, ; uint32_t type_token_id
		i32 82; uint32_t java_map_index
	}, ; 124
	%struct.TypeMapModuleEntry {
		i32 u0x02000148, ; uint32_t type_token_id
		i32 40; uint32_t java_map_index
	}, ; 125
	%struct.TypeMapModuleEntry {
		i32 u0x0200014a, ; uint32_t type_token_id
		i32 74; uint32_t java_map_index
	}, ; 126
	%struct.TypeMapModuleEntry {
		i32 u0x0200014b, ; uint32_t type_token_id
		i32 55; uint32_t java_map_index
	}, ; 127
	%struct.TypeMapModuleEntry {
		i32 u0x0200014c, ; uint32_t type_token_id
		i32 124; uint32_t java_map_index
	}, ; 128
	%struct.TypeMapModuleEntry {
		i32 u0x0200015c, ; uint32_t type_token_id
		i32 58; uint32_t java_map_index
	} ; 129
], align 4

@module1_managed_to_java_duplicates = internal dso_local constant [38 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200005a, ; uint32_t type_token_id
		i32 16; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200005c, ; uint32_t type_token_id
		i32 28; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200005f, ; uint32_t type_token_id
		i32 110; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000064, ; uint32_t type_token_id
		i32 146; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x0200006a, ; uint32_t type_token_id
		i32 111; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000075, ; uint32_t type_token_id
		i32 119; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000080, ; uint32_t type_token_id
		i32 11; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x0200008a, ; uint32_t type_token_id
		i32 144; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x0200008d, ; uint32_t type_token_id
		i32 37; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x0200008e, ; uint32_t type_token_id
		i32 31; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x02000090, ; uint32_t type_token_id
		i32 13; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x02000097, ; uint32_t type_token_id
		i32 8; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x02000099, ; uint32_t type_token_id
		i32 115; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x020000a2, ; uint32_t type_token_id
		i32 26; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x020000bc, ; uint32_t type_token_id
		i32 113; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x020000c2, ; uint32_t type_token_id
		i32 6; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x020000c7, ; uint32_t type_token_id
		i32 62; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x020000cb, ; uint32_t type_token_id
		i32 142; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x020000df, ; uint32_t type_token_id
		i32 32; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x020000eb, ; uint32_t type_token_id
		i32 52; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x020000f0, ; uint32_t type_token_id
		i32 123; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x020000f1, ; uint32_t type_token_id
		i32 59; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x020000f6, ; uint32_t type_token_id
		i32 21; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x020000f8, ; uint32_t type_token_id
		i32 134; uint32_t java_map_index
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 u0x020000fa, ; uint32_t type_token_id
		i32 84; uint32_t java_map_index
	}, ; 24
	%struct.TypeMapModuleEntry {
		i32 u0x0200010e, ; uint32_t type_token_id
		i32 96; uint32_t java_map_index
	}, ; 25
	%struct.TypeMapModuleEntry {
		i32 u0x02000114, ; uint32_t type_token_id
		i32 128; uint32_t java_map_index
	}, ; 26
	%struct.TypeMapModuleEntry {
		i32 u0x02000116, ; uint32_t type_token_id
		i32 135; uint32_t java_map_index
	}, ; 27
	%struct.TypeMapModuleEntry {
		i32 u0x0200011b, ; uint32_t type_token_id
		i32 138; uint32_t java_map_index
	}, ; 28
	%struct.TypeMapModuleEntry {
		i32 u0x0200011d, ; uint32_t type_token_id
		i32 68; uint32_t java_map_index
	}, ; 29
	%struct.TypeMapModuleEntry {
		i32 u0x02000120, ; uint32_t type_token_id
		i32 83; uint32_t java_map_index
	}, ; 30
	%struct.TypeMapModuleEntry {
		i32 u0x02000122, ; uint32_t type_token_id
		i32 57; uint32_t java_map_index
	}, ; 31
	%struct.TypeMapModuleEntry {
		i32 u0x02000124, ; uint32_t type_token_id
		i32 126; uint32_t java_map_index
	}, ; 32
	%struct.TypeMapModuleEntry {
		i32 u0x02000126, ; uint32_t type_token_id
		i32 129; uint32_t java_map_index
	}, ; 33
	%struct.TypeMapModuleEntry {
		i32 u0x0200013c, ; uint32_t type_token_id
		i32 109; uint32_t java_map_index
	}, ; 34
	%struct.TypeMapModuleEntry {
		i32 u0x0200013e, ; uint32_t type_token_id
		i32 65; uint32_t java_map_index
	}, ; 35
	%struct.TypeMapModuleEntry {
		i32 u0x02000144, ; uint32_t type_token_id
		i32 143; uint32_t java_map_index
	}, ; 36
	%struct.TypeMapModuleEntry {
		i32 u0x02000149, ; uint32_t type_token_id
		i32 40; uint32_t java_map_index
	} ; 37
], align 4

@module2_managed_to_java = internal dso_local constant [5 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000002, ; uint32_t type_token_id
		i32 70; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000003, ; uint32_t type_token_id
		i32 105; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000004, ; uint32_t type_token_id
		i32 92; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000009, ; uint32_t type_token_id
		i32 101; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x0200000a, ; uint32_t type_token_id
		i32 25; uint32_t java_map_index
	} ; 4
], align 4

; Java to managed map
@map_java = dso_local local_unnamed_addr constant [147 x %struct.TypeMapJava] [
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000128, ; uint32_t type_token_id
		i32 98; uint32_t java_name_index
	}, ; 0
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000057, ; uint32_t type_token_id
		i32 2; uint32_t java_name_index
	}, ; 1
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000a1, ; uint32_t type_token_id
		i32 46; uint32_t java_name_index
	}, ; 2
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200006c, ; uint32_t type_token_id
		i32 13; uint32_t java_name_index
	}, ; 3
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000084, ; uint32_t type_token_id
		i32 29; uint32_t java_name_index
	}, ; 4
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000c8, ; uint32_t type_token_id
		i32 53; uint32_t java_name_index
	}, ; 5
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000bd, ; uint32_t type_token_id
		i32 51; uint32_t java_name_index
	}, ; 6
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000ee, ; uint32_t type_token_id
		i32 69; uint32_t java_name_index
	}, ; 7
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 40; uint32_t java_name_index
	}, ; 8
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000082, ; uint32_t type_token_id
		i32 27; uint32_t java_name_index
	}, ; 9
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000042, ; uint32_t type_token_id
		i32 139; uint32_t java_name_index
	}, ; 10
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 25; uint32_t java_name_index
	}, ; 11
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000081, ; uint32_t type_token_id
		i32 26; uint32_t java_name_index
	}, ; 12
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 36; uint32_t java_name_index
	}, ; 13
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000f4, ; uint32_t type_token_id
		i32 72; uint32_t java_name_index
	}, ; 14
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200013d, ; uint32_t type_token_id
		i32 117; uint32_t java_name_index
	}, ; 15
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000059, ; uint32_t type_token_id
		i32 4; uint32_t java_name_index
	}, ; 16
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000fc, ; uint32_t type_token_id
		i32 76; uint32_t java_name_index
	}, ; 17
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000e7, ; uint32_t type_token_id
		i32 64; uint32_t java_name_index
	}, ; 18
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000127, ; uint32_t type_token_id
		i32 97; uint32_t java_name_index
	}, ; 19
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000141, ; uint32_t type_token_id
		i32 119; uint32_t java_name_index
	}, ; 20
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 73; uint32_t java_name_index
	}, ; 21
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200003c, ; uint32_t type_token_id
		i32 137; uint32_t java_name_index
	}, ; 22
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000077, ; uint32_t type_token_id
		i32 21; uint32_t java_name_index
	}, ; 23
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000c9, ; uint32_t type_token_id
		i32 54; uint32_t java_name_index
	}, ; 24
	%struct.TypeMapJava {
		i32 2, ; uint32_t module_index
		i32 u0x0200000a, ; uint32_t type_token_id
		i32 146; uint32_t java_name_index
	}, ; 25
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200009f, ; uint32_t type_token_id
		i32 44; uint32_t java_name_index
	}, ; 26
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000083, ; uint32_t type_token_id
		i32 28; uint32_t java_name_index
	}, ; 27
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200005b, ; uint32_t type_token_id
		i32 5; uint32_t java_name_index
	}, ; 28
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000a4, ; uint32_t type_token_id
		i32 48; uint32_t java_name_index
	}, ; 29
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000105, ; uint32_t type_token_id
		i32 80; uint32_t java_name_index
	}, ; 30
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 34; uint32_t java_name_index
	}, ; 31
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000de, ; uint32_t type_token_id
		i32 57; uint32_t java_name_index
	}, ; 32
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200012a, ; uint32_t type_token_id
		i32 100; uint32_t java_name_index
	}, ; 33
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200013a, ; uint32_t type_token_id
		i32 115; uint32_t java_name_index
	}, ; 34
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200006f, ; uint32_t type_token_id
		i32 16; uint32_t java_name_index
	}, ; 35
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000043, ; uint32_t type_token_id
		i32 140; uint32_t java_name_index
	}, ; 36
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 35; uint32_t java_name_index
	}, ; 37
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000104, ; uint32_t type_token_id
		i32 79; uint32_t java_name_index
	}, ; 38
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200009a, ; uint32_t type_token_id
		i32 42; uint32_t java_name_index
	}, ; 39
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000148, ; uint32_t type_token_id
		i32 125; uint32_t java_name_index
	}, ; 40
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000030, ; uint32_t type_token_id
		i32 133; uint32_t java_name_index
	}, ; 41
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000145, ; uint32_t type_token_id
		i32 122; uint32_t java_name_index
	}, ; 42
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200010a, ; uint32_t type_token_id
		i32 82; uint32_t java_name_index
	}, ; 43
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000086, ; uint32_t type_token_id
		i32 31; uint32_t java_name_index
	}, ; 44
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000088, ; uint32_t type_token_id
		i32 32; uint32_t java_name_index
	}, ; 45
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000060, ; uint32_t type_token_id
		i32 7; uint32_t java_name_index
	}, ; 46
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000102, ; uint32_t type_token_id
		i32 77; uint32_t java_name_index
	}, ; 47
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000e4, ; uint32_t type_token_id
		i32 62; uint32_t java_name_index
	}, ; 48
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000f2, ; uint32_t type_token_id
		i32 71; uint32_t java_name_index
	}, ; 49
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000134, ; uint32_t type_token_id
		i32 110; uint32_t java_name_index
	}, ; 50
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200002a, ; uint32_t type_token_id
		i32 131; uint32_t java_name_index
	}, ; 51
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000e9, ; uint32_t type_token_id
		i32 65; uint32_t java_name_index
	}, ; 52
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200011e, ; uint32_t type_token_id
		i32 92; uint32_t java_name_index
	}, ; 53
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000111, ; uint32_t type_token_id
		i32 84; uint32_t java_name_index
	}, ; 54
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200014b, ; uint32_t type_token_id
		i32 127; uint32_t java_name_index
	}, ; 55
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000056, ; uint32_t type_token_id
		i32 1; uint32_t java_name_index
	}, ; 56
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 94; uint32_t java_name_index
	}, ; 57
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200015c, ; uint32_t type_token_id
		i32 129; uint32_t java_name_index
	}, ; 58
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000e6, ; uint32_t type_token_id
		i32 63; uint32_t java_name_index
	}, ; 59
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000066, ; uint32_t type_token_id
		i32 11; uint32_t java_name_index
	}, ; 60
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000036, ; uint32_t type_token_id
		i32 135; uint32_t java_name_index
	}, ; 61
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000c6, ; uint32_t type_token_id
		i32 52; uint32_t java_name_index
	}, ; 62
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000092, ; uint32_t type_token_id
		i32 38; uint32_t java_name_index
	}, ; 63
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200007c, ; uint32_t type_token_id
		i32 23; uint32_t java_name_index
	}, ; 64
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 105; uint32_t java_name_index
	}, ; 65
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000a0, ; uint32_t type_token_id
		i32 45; uint32_t java_name_index
	}, ; 66
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000133, ; uint32_t type_token_id
		i32 109; uint32_t java_name_index
	}, ; 67
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200011c, ; uint32_t type_token_id
		i32 91; uint32_t java_name_index
	}, ; 68
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000129, ; uint32_t type_token_id
		i32 99; uint32_t java_name_index
	}, ; 69
	%struct.TypeMapJava {
		i32 2, ; uint32_t module_index
		i32 u0x02000002, ; uint32_t type_token_id
		i32 142; uint32_t java_name_index
	}, ; 70
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000d6, ; uint32_t type_token_id
		i32 56; uint32_t java_name_index
	}, ; 71
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000139, ; uint32_t type_token_id
		i32 114; uint32_t java_name_index
	}, ; 72
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000137, ; uint32_t type_token_id
		i32 112; uint32_t java_name_index
	}, ; 73
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200014a, ; uint32_t type_token_id
		i32 126; uint32_t java_name_index
	}, ; 74
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200012e, ; uint32_t type_token_id
		i32 104; uint32_t java_name_index
	}, ; 75
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000ec, ; uint32_t type_token_id
		i32 67; uint32_t java_name_index
	}, ; 76
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000b9, ; uint32_t type_token_id
		i32 49; uint32_t java_name_index
	}, ; 77
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000117, ; uint32_t type_token_id
		i32 87; uint32_t java_name_index
	}, ; 78
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000118, ; uint32_t type_token_id
		i32 88; uint32_t java_name_index
	}, ; 79
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000e2, ; uint32_t type_token_id
		i32 60; uint32_t java_name_index
	}, ; 80
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200009e, ; uint32_t type_token_id
		i32 43; uint32_t java_name_index
	}, ; 81
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000147, ; uint32_t type_token_id
		i32 124; uint32_t java_name_index
	}, ; 82
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200011f, ; uint32_t type_token_id
		i32 93; uint32_t java_name_index
	}, ; 83
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 75; uint32_t java_name_index
	}, ; 84
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000135, ; uint32_t type_token_id
		i32 111; uint32_t java_name_index
	}, ; 85
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000e1, ; uint32_t type_token_id
		i32 59; uint32_t java_name_index
	}, ; 86
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000140, ; uint32_t type_token_id
		i32 118; uint32_t java_name_index
	}, ; 87
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000033, ; uint32_t type_token_id
		i32 134; uint32_t java_name_index
	}, ; 88
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000039, ; uint32_t type_token_id
		i32 136; uint32_t java_name_index
	}, ; 89
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000130, ; uint32_t type_token_id
		i32 106; uint32_t java_name_index
	}, ; 90
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200012d, ; uint32_t type_token_id
		i32 103; uint32_t java_name_index
	}, ; 91
	%struct.TypeMapJava {
		i32 2, ; uint32_t module_index
		i32 u0x02000004, ; uint32_t type_token_id
		i32 144; uint32_t java_name_index
	}, ; 92
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000a3, ; uint32_t type_token_id
		i32 47; uint32_t java_name_index
	}, ; 93
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200006d, ; uint32_t type_token_id
		i32 14; uint32_t java_name_index
	}, ; 94
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200002d, ; uint32_t type_token_id
		i32 132; uint32_t java_name_index
	}, ; 95
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200010d, ; uint32_t type_token_id
		i32 83; uint32_t java_name_index
	}, ; 96
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000095, ; uint32_t type_token_id
		i32 39; uint32_t java_name_index
	}, ; 97
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000ea, ; uint32_t type_token_id
		i32 66; uint32_t java_name_index
	}, ; 98
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000061, ; uint32_t type_token_id
		i32 8; uint32_t java_name_index
	}, ; 99
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000091, ; uint32_t type_token_id
		i32 37; uint32_t java_name_index
	}, ; 100
	%struct.TypeMapJava {
		i32 2, ; uint32_t module_index
		i32 u0x02000009, ; uint32_t type_token_id
		i32 145; uint32_t java_name_index
	}, ; 101
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000132, ; uint32_t type_token_id
		i32 108; uint32_t java_name_index
	}, ; 102
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000e3, ; uint32_t type_token_id
		i32 61; uint32_t java_name_index
	}, ; 103
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200012b, ; uint32_t type_token_id
		i32 101; uint32_t java_name_index
	}, ; 104
	%struct.TypeMapJava {
		i32 2, ; uint32_t module_index
		i32 u0x02000003, ; uint32_t type_token_id
		i32 143; uint32_t java_name_index
	}, ; 105
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000ed, ; uint32_t type_token_id
		i32 68; uint32_t java_name_index
	}, ; 106
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000e0, ; uint32_t type_token_id
		i32 58; uint32_t java_name_index
	}, ; 107
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000138, ; uint32_t type_token_id
		i32 113; uint32_t java_name_index
	}, ; 108
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200013b, ; uint32_t type_token_id
		i32 116; uint32_t java_name_index
	}, ; 109
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 6; uint32_t java_name_index
	}, ; 110
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000062, ; uint32_t type_token_id
		i32 9; uint32_t java_name_index
	}, ; 111
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000073, ; uint32_t type_token_id
		i32 19; uint32_t java_name_index
	}, ; 112
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000bb, ; uint32_t type_token_id
		i32 50; uint32_t java_name_index
	}, ; 113
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000106, ; uint32_t type_token_id
		i32 81; uint32_t java_name_index
	}, ; 114
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 41; uint32_t java_name_index
	}, ; 115
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000103, ; uint32_t type_token_id
		i32 78; uint32_t java_name_index
	}, ; 116
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200012c, ; uint32_t type_token_id
		i32 102; uint32_t java_name_index
	}, ; 117
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200006b, ; uint32_t type_token_id
		i32 12; uint32_t java_name_index
	}, ; 118
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 20; uint32_t java_name_index
	}, ; 119
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200003f, ; uint32_t type_token_id
		i32 138; uint32_t java_name_index
	}, ; 120
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000085, ; uint32_t type_token_id
		i32 30; uint32_t java_name_index
	}, ; 121
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200007e, ; uint32_t type_token_id
		i32 24; uint32_t java_name_index
	}, ; 122
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000ef, ; uint32_t type_token_id
		i32 70; uint32_t java_name_index
	}, ; 123
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200014c, ; uint32_t type_token_id
		i32 128; uint32_t java_name_index
	}, ; 124
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 130; uint32_t java_name_index
	}, ; 125
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 95; uint32_t java_name_index
	}, ; 126
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000146, ; uint32_t type_token_id
		i32 123; uint32_t java_name_index
	}, ; 127
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000113, ; uint32_t type_token_id
		i32 85; uint32_t java_name_index
	}, ; 128
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 96; uint32_t java_name_index
	}, ; 129
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200006e, ; uint32_t type_token_id
		i32 15; uint32_t java_name_index
	}, ; 130
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000089, ; uint32_t type_token_id
		i32 141; uint32_t java_name_index
	}, ; 131
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000058, ; uint32_t type_token_id
		i32 3; uint32_t java_name_index
	}, ; 132
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000131, ; uint32_t type_token_id
		i32 107; uint32_t java_name_index
	}, ; 133
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 74; uint32_t java_name_index
	}, ; 134
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000115, ; uint32_t type_token_id
		i32 86; uint32_t java_name_index
	}, ; 135
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000119, ; uint32_t type_token_id
		i32 89; uint32_t java_name_index
	}, ; 136
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000070, ; uint32_t type_token_id
		i32 17; uint32_t java_name_index
	}, ; 137
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 90; uint32_t java_name_index
	}, ; 138
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000142, ; uint32_t type_token_id
		i32 120; uint32_t java_name_index
	}, ; 139
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000055, ; uint32_t type_token_id
		i32 0; uint32_t java_name_index
	}, ; 140
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200007b, ; uint32_t type_token_id
		i32 22; uint32_t java_name_index
	}, ; 141
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000ca, ; uint32_t type_token_id
		i32 55; uint32_t java_name_index
	}, ; 142
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 121; uint32_t java_name_index
	}, ; 143
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 33; uint32_t java_name_index
	}, ; 144
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000071, ; uint32_t type_token_id
		i32 18; uint32_t java_name_index
	}, ; 145
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 10; uint32_t java_name_index
	} ; 146
], align 4

; Java type names
@java_type_names = dso_local local_unnamed_addr constant [147 x ptr] [
	ptr @.tmr.0, ; 0 ('android/provider/MediaStore')
	ptr @.tmr.1, ; 1 ('android/provider/MediaStore$Images')
	ptr @.tmr.2, ; 2 ('android/provider/MediaStore$Images$Media')
	ptr @.tmr.3, ; 3 ('android/database/CharArrayBuffer')
	ptr @.tmr.4, ; 4 ('android/database/ContentObserver')
	ptr @.tmr.5, ; 5 ('android/database/DataSetObserver')
	ptr @.tmr.6, ; 6 ('android/database/Cursor')
	ptr @.tmr.7, ; 7 ('android/widget/TextView')
	ptr @.tmr.8, ; 8 ('android/widget/Button')
	ptr @.tmr.9, ; 9 ('android/widget/CompoundButton')
	ptr @.tmr.10, ; 10 ('android/widget/CompoundButton$OnCheckedChangeListener')
	ptr @.tmr.11, ; 11 ('mono/android/widget/CompoundButton_OnCheckedChangeListenerImplementor')
	ptr @.tmr.12, ; 12 ('android/widget/GridLayout')
	ptr @.tmr.13, ; 13 ('android/widget/GridLayout$LayoutParams')
	ptr @.tmr.14, ; 14 ('android/widget/GridLayout$Spec')
	ptr @.tmr.15, ; 15 ('android/widget/ImageView')
	ptr @.tmr.16, ; 16 ('android/widget/ImageView$ScaleType')
	ptr @.tmr.17, ; 17 ('android/widget/LinearLayout')
	ptr @.tmr.18, ; 18 ('android/widget/LinearLayout$LayoutParams')
	ptr @.tmr.19, ; 19 ('android/widget/RadioGroup')
	ptr @.tmr.20, ; 20 ('android/widget/RadioGroup$OnCheckedChangeListener')
	ptr @.tmr.21, ; 21 ('mono/android/widget/RadioGroup_OnCheckedChangeListenerImplementor')
	ptr @.tmr.22, ; 22 ('android/widget/Switch')
	ptr @.tmr.23, ; 23 ('android/widget/Toast')
	ptr @.tmr.24, ; 24 ('android/util/DisplayMetrics')
	ptr @.tmr.25, ; 25 ('android/util/AttributeSet')
	ptr @.tmr.26, ; 26 ('android/os/Handler')
	ptr @.tmr.27, ; 27 ('android/os/PowerManager')
	ptr @.tmr.28, ; 28 ('android/os/PowerManager$WakeLock')
	ptr @.tmr.29, ; 29 ('android/os/BaseBundle')
	ptr @.tmr.30, ; 30 ('android/os/Build')
	ptr @.tmr.31, ; 31 ('android/os/Build$VERSION')
	ptr @.tmr.32, ; 32 ('android/os/Bundle')
	ptr @.tmr.33, ; 33 ('android/os/IBinder$DeathRecipient')
	ptr @.tmr.34, ; 34 ('android/os/IBinder')
	ptr @.tmr.35, ; 35 ('android/os/IBinder$FrozenStateChangeCallback')
	ptr @.tmr.36, ; 36 ('android/os/IInterface')
	ptr @.tmr.37, ; 37 ('android/os/Looper')
	ptr @.tmr.38, ; 38 ('android/os/Parcel')
	ptr @.tmr.39, ; 39 ('android/view/View')
	ptr @.tmr.40, ; 40 ('android/view/View$OnApplyWindowInsetsListener')
	ptr @.tmr.41, ; 41 ('android/view/View$OnClickListener')
	ptr @.tmr.42, ; 42 ('mono/android/view/View_OnClickListenerImplementor')
	ptr @.tmr.43, ; 43 ('android/view/ContextThemeWrapper')
	ptr @.tmr.44, ; 44 ('android/view/ViewGroup')
	ptr @.tmr.45, ; 45 ('android/view/ViewGroup$LayoutParams')
	ptr @.tmr.46, ; 46 ('android/view/ViewGroup$MarginLayoutParams')
	ptr @.tmr.47, ; 47 ('android/view/WindowInsets')
	ptr @.tmr.48, ; 48 ('android/view/WindowInsets$Type')
	ptr @.tmr.49, ; 49 ('mono/android/runtime/InputStreamAdapter')
	ptr @.tmr.50, ; 50 ('java/util/Collection')
	ptr @.tmr.51, ; 51 ('java/util/HashMap')
	ptr @.tmr.52, ; 52 ('java/util/ArrayList')
	ptr @.tmr.53, ; 53 ('mono/android/runtime/JavaObject')
	ptr @.tmr.54, ; 54 ('android/runtime/JavaProxyThrowable')
	ptr @.tmr.55, ; 55 ('java/util/HashSet')
	ptr @.tmr.56, ; 56 ('mono/android/runtime/OutputStreamAdapter')
	ptr @.tmr.57, ; 57 ('android/net/Uri')
	ptr @.tmr.58, ; 58 ('android/graphics/Bitmap')
	ptr @.tmr.59, ; 59 ('android/graphics/BitmapFactory')
	ptr @.tmr.60, ; 60 ('android/graphics/BitmapFactory$Options')
	ptr @.tmr.61, ; 61 ('android/graphics/Insets')
	ptr @.tmr.62, ; 62 ('android/graphics/Rect')
	ptr @.tmr.63, ; 63 ('android/content/Context')
	ptr @.tmr.64, ; 64 ('android/content/Intent')
	ptr @.tmr.65, ; 65 ('android/content/BroadcastReceiver')
	ptr @.tmr.66, ; 66 ('android/content/BroadcastReceiver$PendingResult')
	ptr @.tmr.67, ; 67 ('android/content/ClipData')
	ptr @.tmr.68, ; 68 ('android/content/ClipData$Item')
	ptr @.tmr.69, ; 69 ('android/content/ComponentName')
	ptr @.tmr.70, ; 70 ('android/content/ContentResolver')
	ptr @.tmr.71, ; 71 ('android/content/ContextWrapper')
	ptr @.tmr.72, ; 72 ('android/content/IntentFilter')
	ptr @.tmr.73, ; 73 ('android/content/SharedPreferences$Editor')
	ptr @.tmr.74, ; 74 ('android/content/SharedPreferences$OnSharedPreferenceChangeListener')
	ptr @.tmr.75, ; 75 ('android/content/SharedPreferences')
	ptr @.tmr.76, ; 76 ('android/content/res/Resources')
	ptr @.tmr.77, ; 77 ('android/app/Activity')
	ptr @.tmr.78, ; 78 ('android/app/Application')
	ptr @.tmr.79, ; 79 ('android/app/Notification')
	ptr @.tmr.80, ; 80 ('android/app/Notification$Builder')
	ptr @.tmr.81, ; 81 ('android/app/NotificationManager')
	ptr @.tmr.82, ; 82 ('android/app/NotificationChannel')
	ptr @.tmr.83, ; 83 ('android/app/Service')
	ptr @.tmr.84, ; 84 ('android/app/WallpaperManager')
	ptr @.tmr.85, ; 85 ('java/nio/channels/FileChannel')
	ptr @.tmr.86, ; 86 ('java/nio/channels/spi/AbstractInterruptibleChannel')
	ptr @.tmr.87, ; 87 ('java/io/File')
	ptr @.tmr.88, ; 88 ('java/io/FileDescriptor')
	ptr @.tmr.89, ; 89 ('java/io/FileInputStream')
	ptr @.tmr.90, ; 90 ('java/io/Closeable')
	ptr @.tmr.91, ; 91 ('java/io/InputStream')
	ptr @.tmr.92, ; 92 ('java/io/IOException')
	ptr @.tmr.93, ; 93 ('java/io/OutputStream')
	ptr @.tmr.94, ; 94 ('java/util/Iterator')
	ptr @.tmr.95, ; 95 ('java/util/function/Consumer')
	ptr @.tmr.96, ; 96 ('java/util/concurrent/Executor')
	ptr @.tmr.97, ; 97 ('java/lang/Boolean')
	ptr @.tmr.98, ; 98 ('java/lang/Byte')
	ptr @.tmr.99, ; 99 ('java/lang/Character')
	ptr @.tmr.100, ; 100 ('java/lang/Class')
	ptr @.tmr.101, ; 101 ('java/lang/ClassNotFoundException')
	ptr @.tmr.102, ; 102 ('java/lang/Double')
	ptr @.tmr.103, ; 103 ('java/lang/Exception')
	ptr @.tmr.104, ; 104 ('java/lang/Float')
	ptr @.tmr.105, ; 105 ('java/lang/CharSequence')
	ptr @.tmr.106, ; 106 ('java/lang/Integer')
	ptr @.tmr.107, ; 107 ('java/lang/Long')
	ptr @.tmr.108, ; 108 ('java/lang/Object')
	ptr @.tmr.109, ; 109 ('java/lang/RuntimeException')
	ptr @.tmr.110, ; 110 ('java/lang/Short')
	ptr @.tmr.111, ; 111 ('java/lang/String')
	ptr @.tmr.112, ; 112 ('java/lang/Thread')
	ptr @.tmr.113, ; 113 ('mono/java/lang/RunnableImplementor')
	ptr @.tmr.114, ; 114 ('java/lang/Throwable')
	ptr @.tmr.115, ; 115 ('java/lang/ClassCastException')
	ptr @.tmr.116, ; 116 ('java/lang/Enum')
	ptr @.tmr.117, ; 117 ('java/lang/Error')
	ptr @.tmr.118, ; 118 ('java/lang/IllegalArgumentException')
	ptr @.tmr.119, ; 119 ('java/lang/IllegalStateException')
	ptr @.tmr.120, ; 120 ('java/lang/IndexOutOfBoundsException')
	ptr @.tmr.121, ; 121 ('java/lang/Runnable')
	ptr @.tmr.122, ; 122 ('java/lang/LinkageError')
	ptr @.tmr.123, ; 123 ('java/lang/NoClassDefFoundError')
	ptr @.tmr.124, ; 124 ('java/lang/NullPointerException')
	ptr @.tmr.125, ; 125 ('java/lang/Number')
	ptr @.tmr.126, ; 126 ('java/lang/ReflectiveOperationException')
	ptr @.tmr.127, ; 127 ('java/lang/StackTraceElement')
	ptr @.tmr.128, ; 128 ('java/lang/UnsupportedOperationException')
	ptr @.tmr.129, ; 129 ('mono/android/TypeManager')
	ptr @.tmr.130, ; 130 ('[Ljava/lang/Object;')
	ptr @.tmr.131, ; 131 ('[Z')
	ptr @.tmr.132, ; 132 ('[B')
	ptr @.tmr.133, ; 133 ('[C')
	ptr @.tmr.134, ; 134 ('[S')
	ptr @.tmr.135, ; 135 ('[I')
	ptr @.tmr.136, ; 136 ('[J')
	ptr @.tmr.137, ; 137 ('[F')
	ptr @.tmr.138, ; 138 ('[D')
	ptr @.tmr.139, ; 139 ('net/dot/jni/internal/JavaProxyObject')
	ptr @.tmr.140, ; 140 ('net/dot/jni/internal/JavaProxyThrowable')
	ptr @.tmr.141, ; 141 ('net/dot/jni/ManagedPeer')
	ptr @.tmr.142, ; 142 ('crc640229306f97c153b1/BootReceiver')
	ptr @.tmr.143, ; 143 ('crc640229306f97c153b1/MainActivity')
	ptr @.tmr.144, ; 144 ('crc640229306f97c153b1/MainActivity_InsetsListener')
	ptr @.tmr.145, ; 145 ('crc640229306f97c153b1/WallpaperMonitorService')
	ptr @.tmr.146 ; 146 ('crc640229306f97c153b1/ScreenReceiver')
], align 8

; Strings
@.tmr.0 = private unnamed_addr constant [28 x i8] c"android/provider/MediaStore\00", align 1
@.tmr.1 = private unnamed_addr constant [35 x i8] c"android/provider/MediaStore$Images\00", align 1
@.tmr.2 = private unnamed_addr constant [41 x i8] c"android/provider/MediaStore$Images$Media\00", align 1
@.tmr.3 = private unnamed_addr constant [33 x i8] c"android/database/CharArrayBuffer\00", align 1
@.tmr.4 = private unnamed_addr constant [33 x i8] c"android/database/ContentObserver\00", align 1
@.tmr.5 = private unnamed_addr constant [33 x i8] c"android/database/DataSetObserver\00", align 1
@.tmr.6 = private unnamed_addr constant [24 x i8] c"android/database/Cursor\00", align 1
@.tmr.7 = private unnamed_addr constant [24 x i8] c"android/widget/TextView\00", align 1
@.tmr.8 = private unnamed_addr constant [22 x i8] c"android/widget/Button\00", align 1
@.tmr.9 = private unnamed_addr constant [30 x i8] c"android/widget/CompoundButton\00", align 1
@.tmr.10 = private unnamed_addr constant [54 x i8] c"android/widget/CompoundButton$OnCheckedChangeListener\00", align 1
@.tmr.11 = private unnamed_addr constant [70 x i8] c"mono/android/widget/CompoundButton_OnCheckedChangeListenerImplementor\00", align 1
@.tmr.12 = private unnamed_addr constant [26 x i8] c"android/widget/GridLayout\00", align 1
@.tmr.13 = private unnamed_addr constant [39 x i8] c"android/widget/GridLayout$LayoutParams\00", align 1
@.tmr.14 = private unnamed_addr constant [31 x i8] c"android/widget/GridLayout$Spec\00", align 1
@.tmr.15 = private unnamed_addr constant [25 x i8] c"android/widget/ImageView\00", align 1
@.tmr.16 = private unnamed_addr constant [35 x i8] c"android/widget/ImageView$ScaleType\00", align 1
@.tmr.17 = private unnamed_addr constant [28 x i8] c"android/widget/LinearLayout\00", align 1
@.tmr.18 = private unnamed_addr constant [41 x i8] c"android/widget/LinearLayout$LayoutParams\00", align 1
@.tmr.19 = private unnamed_addr constant [26 x i8] c"android/widget/RadioGroup\00", align 1
@.tmr.20 = private unnamed_addr constant [50 x i8] c"android/widget/RadioGroup$OnCheckedChangeListener\00", align 1
@.tmr.21 = private unnamed_addr constant [66 x i8] c"mono/android/widget/RadioGroup_OnCheckedChangeListenerImplementor\00", align 1
@.tmr.22 = private unnamed_addr constant [22 x i8] c"android/widget/Switch\00", align 1
@.tmr.23 = private unnamed_addr constant [21 x i8] c"android/widget/Toast\00", align 1
@.tmr.24 = private unnamed_addr constant [28 x i8] c"android/util/DisplayMetrics\00", align 1
@.tmr.25 = private unnamed_addr constant [26 x i8] c"android/util/AttributeSet\00", align 1
@.tmr.26 = private unnamed_addr constant [19 x i8] c"android/os/Handler\00", align 1
@.tmr.27 = private unnamed_addr constant [24 x i8] c"android/os/PowerManager\00", align 1
@.tmr.28 = private unnamed_addr constant [33 x i8] c"android/os/PowerManager$WakeLock\00", align 1
@.tmr.29 = private unnamed_addr constant [22 x i8] c"android/os/BaseBundle\00", align 1
@.tmr.30 = private unnamed_addr constant [17 x i8] c"android/os/Build\00", align 1
@.tmr.31 = private unnamed_addr constant [25 x i8] c"android/os/Build$VERSION\00", align 1
@.tmr.32 = private unnamed_addr constant [18 x i8] c"android/os/Bundle\00", align 1
@.tmr.33 = private unnamed_addr constant [34 x i8] c"android/os/IBinder$DeathRecipient\00", align 1
@.tmr.34 = private unnamed_addr constant [19 x i8] c"android/os/IBinder\00", align 1
@.tmr.35 = private unnamed_addr constant [45 x i8] c"android/os/IBinder$FrozenStateChangeCallback\00", align 1
@.tmr.36 = private unnamed_addr constant [22 x i8] c"android/os/IInterface\00", align 1
@.tmr.37 = private unnamed_addr constant [18 x i8] c"android/os/Looper\00", align 1
@.tmr.38 = private unnamed_addr constant [18 x i8] c"android/os/Parcel\00", align 1
@.tmr.39 = private unnamed_addr constant [18 x i8] c"android/view/View\00", align 1
@.tmr.40 = private unnamed_addr constant [46 x i8] c"android/view/View$OnApplyWindowInsetsListener\00", align 1
@.tmr.41 = private unnamed_addr constant [34 x i8] c"android/view/View$OnClickListener\00", align 1
@.tmr.42 = private unnamed_addr constant [50 x i8] c"mono/android/view/View_OnClickListenerImplementor\00", align 1
@.tmr.43 = private unnamed_addr constant [33 x i8] c"android/view/ContextThemeWrapper\00", align 1
@.tmr.44 = private unnamed_addr constant [23 x i8] c"android/view/ViewGroup\00", align 1
@.tmr.45 = private unnamed_addr constant [36 x i8] c"android/view/ViewGroup$LayoutParams\00", align 1
@.tmr.46 = private unnamed_addr constant [42 x i8] c"android/view/ViewGroup$MarginLayoutParams\00", align 1
@.tmr.47 = private unnamed_addr constant [26 x i8] c"android/view/WindowInsets\00", align 1
@.tmr.48 = private unnamed_addr constant [31 x i8] c"android/view/WindowInsets$Type\00", align 1
@.tmr.49 = private unnamed_addr constant [40 x i8] c"mono/android/runtime/InputStreamAdapter\00", align 1
@.tmr.50 = private unnamed_addr constant [21 x i8] c"java/util/Collection\00", align 1
@.tmr.51 = private unnamed_addr constant [18 x i8] c"java/util/HashMap\00", align 1
@.tmr.52 = private unnamed_addr constant [20 x i8] c"java/util/ArrayList\00", align 1
@.tmr.53 = private unnamed_addr constant [32 x i8] c"mono/android/runtime/JavaObject\00", align 1
@.tmr.54 = private unnamed_addr constant [35 x i8] c"android/runtime/JavaProxyThrowable\00", align 1
@.tmr.55 = private unnamed_addr constant [18 x i8] c"java/util/HashSet\00", align 1
@.tmr.56 = private unnamed_addr constant [41 x i8] c"mono/android/runtime/OutputStreamAdapter\00", align 1
@.tmr.57 = private unnamed_addr constant [16 x i8] c"android/net/Uri\00", align 1
@.tmr.58 = private unnamed_addr constant [24 x i8] c"android/graphics/Bitmap\00", align 1
@.tmr.59 = private unnamed_addr constant [31 x i8] c"android/graphics/BitmapFactory\00", align 1
@.tmr.60 = private unnamed_addr constant [39 x i8] c"android/graphics/BitmapFactory$Options\00", align 1
@.tmr.61 = private unnamed_addr constant [24 x i8] c"android/graphics/Insets\00", align 1
@.tmr.62 = private unnamed_addr constant [22 x i8] c"android/graphics/Rect\00", align 1
@.tmr.63 = private unnamed_addr constant [24 x i8] c"android/content/Context\00", align 1
@.tmr.64 = private unnamed_addr constant [23 x i8] c"android/content/Intent\00", align 1
@.tmr.65 = private unnamed_addr constant [34 x i8] c"android/content/BroadcastReceiver\00", align 1
@.tmr.66 = private unnamed_addr constant [48 x i8] c"android/content/BroadcastReceiver$PendingResult\00", align 1
@.tmr.67 = private unnamed_addr constant [25 x i8] c"android/content/ClipData\00", align 1
@.tmr.68 = private unnamed_addr constant [30 x i8] c"android/content/ClipData$Item\00", align 1
@.tmr.69 = private unnamed_addr constant [30 x i8] c"android/content/ComponentName\00", align 1
@.tmr.70 = private unnamed_addr constant [32 x i8] c"android/content/ContentResolver\00", align 1
@.tmr.71 = private unnamed_addr constant [31 x i8] c"android/content/ContextWrapper\00", align 1
@.tmr.72 = private unnamed_addr constant [29 x i8] c"android/content/IntentFilter\00", align 1
@.tmr.73 = private unnamed_addr constant [41 x i8] c"android/content/SharedPreferences$Editor\00", align 1
@.tmr.74 = private unnamed_addr constant [67 x i8] c"android/content/SharedPreferences$OnSharedPreferenceChangeListener\00", align 1
@.tmr.75 = private unnamed_addr constant [34 x i8] c"android/content/SharedPreferences\00", align 1
@.tmr.76 = private unnamed_addr constant [30 x i8] c"android/content/res/Resources\00", align 1
@.tmr.77 = private unnamed_addr constant [21 x i8] c"android/app/Activity\00", align 1
@.tmr.78 = private unnamed_addr constant [24 x i8] c"android/app/Application\00", align 1
@.tmr.79 = private unnamed_addr constant [25 x i8] c"android/app/Notification\00", align 1
@.tmr.80 = private unnamed_addr constant [33 x i8] c"android/app/Notification$Builder\00", align 1
@.tmr.81 = private unnamed_addr constant [32 x i8] c"android/app/NotificationManager\00", align 1
@.tmr.82 = private unnamed_addr constant [32 x i8] c"android/app/NotificationChannel\00", align 1
@.tmr.83 = private unnamed_addr constant [20 x i8] c"android/app/Service\00", align 1
@.tmr.84 = private unnamed_addr constant [29 x i8] c"android/app/WallpaperManager\00", align 1
@.tmr.85 = private unnamed_addr constant [30 x i8] c"java/nio/channels/FileChannel\00", align 1
@.tmr.86 = private unnamed_addr constant [51 x i8] c"java/nio/channels/spi/AbstractInterruptibleChannel\00", align 1
@.tmr.87 = private unnamed_addr constant [13 x i8] c"java/io/File\00", align 1
@.tmr.88 = private unnamed_addr constant [23 x i8] c"java/io/FileDescriptor\00", align 1
@.tmr.89 = private unnamed_addr constant [24 x i8] c"java/io/FileInputStream\00", align 1
@.tmr.90 = private unnamed_addr constant [18 x i8] c"java/io/Closeable\00", align 1
@.tmr.91 = private unnamed_addr constant [20 x i8] c"java/io/InputStream\00", align 1
@.tmr.92 = private unnamed_addr constant [20 x i8] c"java/io/IOException\00", align 1
@.tmr.93 = private unnamed_addr constant [21 x i8] c"java/io/OutputStream\00", align 1
@.tmr.94 = private unnamed_addr constant [19 x i8] c"java/util/Iterator\00", align 1
@.tmr.95 = private unnamed_addr constant [28 x i8] c"java/util/function/Consumer\00", align 1
@.tmr.96 = private unnamed_addr constant [30 x i8] c"java/util/concurrent/Executor\00", align 1
@.tmr.97 = private unnamed_addr constant [18 x i8] c"java/lang/Boolean\00", align 1
@.tmr.98 = private unnamed_addr constant [15 x i8] c"java/lang/Byte\00", align 1
@.tmr.99 = private unnamed_addr constant [20 x i8] c"java/lang/Character\00", align 1
@.tmr.100 = private unnamed_addr constant [16 x i8] c"java/lang/Class\00", align 1
@.tmr.101 = private unnamed_addr constant [33 x i8] c"java/lang/ClassNotFoundException\00", align 1
@.tmr.102 = private unnamed_addr constant [17 x i8] c"java/lang/Double\00", align 1
@.tmr.103 = private unnamed_addr constant [20 x i8] c"java/lang/Exception\00", align 1
@.tmr.104 = private unnamed_addr constant [16 x i8] c"java/lang/Float\00", align 1
@.tmr.105 = private unnamed_addr constant [23 x i8] c"java/lang/CharSequence\00", align 1
@.tmr.106 = private unnamed_addr constant [18 x i8] c"java/lang/Integer\00", align 1
@.tmr.107 = private unnamed_addr constant [15 x i8] c"java/lang/Long\00", align 1
@.tmr.108 = private unnamed_addr constant [17 x i8] c"java/lang/Object\00", align 1
@.tmr.109 = private unnamed_addr constant [27 x i8] c"java/lang/RuntimeException\00", align 1
@.tmr.110 = private unnamed_addr constant [16 x i8] c"java/lang/Short\00", align 1
@.tmr.111 = private unnamed_addr constant [17 x i8] c"java/lang/String\00", align 1
@.tmr.112 = private unnamed_addr constant [17 x i8] c"java/lang/Thread\00", align 1
@.tmr.113 = private unnamed_addr constant [35 x i8] c"mono/java/lang/RunnableImplementor\00", align 1
@.tmr.114 = private unnamed_addr constant [20 x i8] c"java/lang/Throwable\00", align 1
@.tmr.115 = private unnamed_addr constant [29 x i8] c"java/lang/ClassCastException\00", align 1
@.tmr.116 = private unnamed_addr constant [15 x i8] c"java/lang/Enum\00", align 1
@.tmr.117 = private unnamed_addr constant [16 x i8] c"java/lang/Error\00", align 1
@.tmr.118 = private unnamed_addr constant [35 x i8] c"java/lang/IllegalArgumentException\00", align 1
@.tmr.119 = private unnamed_addr constant [32 x i8] c"java/lang/IllegalStateException\00", align 1
@.tmr.120 = private unnamed_addr constant [36 x i8] c"java/lang/IndexOutOfBoundsException\00", align 1
@.tmr.121 = private unnamed_addr constant [19 x i8] c"java/lang/Runnable\00", align 1
@.tmr.122 = private unnamed_addr constant [23 x i8] c"java/lang/LinkageError\00", align 1
@.tmr.123 = private unnamed_addr constant [31 x i8] c"java/lang/NoClassDefFoundError\00", align 1
@.tmr.124 = private unnamed_addr constant [31 x i8] c"java/lang/NullPointerException\00", align 1
@.tmr.125 = private unnamed_addr constant [17 x i8] c"java/lang/Number\00", align 1
@.tmr.126 = private unnamed_addr constant [39 x i8] c"java/lang/ReflectiveOperationException\00", align 1
@.tmr.127 = private unnamed_addr constant [28 x i8] c"java/lang/StackTraceElement\00", align 1
@.tmr.128 = private unnamed_addr constant [40 x i8] c"java/lang/UnsupportedOperationException\00", align 1
@.tmr.129 = private unnamed_addr constant [25 x i8] c"mono/android/TypeManager\00", align 1
@.tmr.130 = private unnamed_addr constant [20 x i8] c"[Ljava/lang/Object;\00", align 1
@.tmr.131 = private unnamed_addr constant [3 x i8] c"[Z\00", align 1
@.tmr.132 = private unnamed_addr constant [3 x i8] c"[B\00", align 1
@.tmr.133 = private unnamed_addr constant [3 x i8] c"[C\00", align 1
@.tmr.134 = private unnamed_addr constant [3 x i8] c"[S\00", align 1
@.tmr.135 = private unnamed_addr constant [3 x i8] c"[I\00", align 1
@.tmr.136 = private unnamed_addr constant [3 x i8] c"[J\00", align 1
@.tmr.137 = private unnamed_addr constant [3 x i8] c"[F\00", align 1
@.tmr.138 = private unnamed_addr constant [3 x i8] c"[D\00", align 1
@.tmr.139 = private unnamed_addr constant [37 x i8] c"net/dot/jni/internal/JavaProxyObject\00", align 1
@.tmr.140 = private unnamed_addr constant [40 x i8] c"net/dot/jni/internal/JavaProxyThrowable\00", align 1
@.tmr.141 = private unnamed_addr constant [24 x i8] c"net/dot/jni/ManagedPeer\00", align 1
@.tmr.142 = private unnamed_addr constant [35 x i8] c"crc640229306f97c153b1/BootReceiver\00", align 1
@.tmr.143 = private unnamed_addr constant [35 x i8] c"crc640229306f97c153b1/MainActivity\00", align 1
@.tmr.144 = private unnamed_addr constant [50 x i8] c"crc640229306f97c153b1/MainActivity_InsetsListener\00", align 1
@.tmr.145 = private unnamed_addr constant [46 x i8] c"crc640229306f97c153b1/WallpaperMonitorService\00", align 1
@.tmr.146 = private unnamed_addr constant [37 x i8] c"crc640229306f97c153b1/ScreenReceiver\00", align 1

;TypeMapModule
@.TypeMapModule.0_assembly_name = private unnamed_addr constant [13 x i8] c"Java.Interop\00", align 1
@.TypeMapModule.1_assembly_name = private unnamed_addr constant [13 x i8] c"Mono.Android\00", align 1
@.TypeMapModule.2_assembly_name = private unnamed_addr constant [15 x i8] c"wallpaperTrade\00", align 1

; Metadata
!llvm.module.flags = !{!0, !1, !7, !8, !9, !10}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!".NET for Android remotes/origin/release/10.0.1xx @ d549e1dc4e2a083b08b4f24cb5495e81b99d79b5"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"branch-target-enforcement", i32 0}
!8 = !{i32 1, !"sign-return-address", i32 0}
!9 = !{i32 1, !"sign-return-address-all", i32 0}
!10 = !{i32 1, !"sign-return-address-with-bkey", i32 0}
