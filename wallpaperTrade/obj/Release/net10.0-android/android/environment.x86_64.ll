; ModuleID = 'environment.x86_64.ll'
source_filename = "environment.x86_64.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-android21"

%struct.ApplicationConfig = type {
	i1, ; bool uses_mono_llvm
	i1, ; bool uses_mono_aot
	i1, ; bool aot_lazy_load
	i1, ; bool uses_assembly_preload
	i1, ; bool broken_exception_transitions
	i1, ; bool jni_add_native_method_registration_attribute_present
	i1, ; bool have_runtime_config_blob
	i1, ; bool have_assemblies_blob
	i1, ; bool marshal_methods_enabled
	i1, ; bool ignore_split_configs
	i8, ; uint8_t bound_stream_io_exception_type
	i32, ; uint32_t package_naming_policy
	i32, ; uint32_t environment_variable_count
	i32, ; uint32_t system_property_count
	i32, ; uint32_t number_of_assemblies_in_apk
	i32, ; uint32_t bundled_assembly_name_width
	i32, ; uint32_t number_of_dso_cache_entries
	i32, ; uint32_t number_of_aot_cache_entries
	i32, ; uint32_t number_of_shared_libraries
	i32, ; uint32_t android_runtime_jnienv_class_token
	i32, ; uint32_t jnienv_initialize_method_token
	i32, ; uint32_t jnienv_registerjninatives_method_token
	i32, ; uint32_t jni_remapping_replacement_type_count
	i32, ; uint32_t jni_remapping_replacement_method_index_entry_count
	i32, ; uint32_t mono_components_mask
	ptr, ; char* android_package_name
	i1 ; bool managed_marshal_methods_lookup_enabled
}

%struct.AssemblyStoreAssemblyDescriptor = type {
	i32, ; uint32_t data_offset
	i32, ; uint32_t data_size
	i32, ; uint32_t debug_data_offset
	i32, ; uint32_t debug_data_size
	i32, ; uint32_t config_data_offset
	i32 ; uint32_t config_data_size
}

%struct.AssemblyStoreRuntimeData = type {
	ptr, ; uint8_t data_start
	i32, ; uint32_t assembly_count
	i32, ; uint32_t index_entry_count
	ptr ; AssemblyStoreAssemblyDescriptor assemblies
}

%struct.AssemblyStoreSingleAssemblyRuntimeData = type {
	ptr, ; uint8_t image_data
	ptr, ; uint8_t debug_info_data
	ptr, ; uint8_t config_data
	ptr ; AssemblyStoreAssemblyDescriptor descriptor
}

%struct.DSOApkEntry = type {
	i64, ; uint64_t name_hash
	i32, ; uint32_t offset
	i32 ; int32_t fd
}

%struct.DSOCacheEntry = type {
	i64, ; uint64_t hash
	i64, ; uint64_t real_name_hash
	i1, ; bool ignore
	i1, ; bool is_jni_library
	ptr, ; char* name
	ptr ; void* handle
}

%struct.XamarinAndroidBundledAssembly = type {
	i32, ; int32_t file_fd
	ptr, ; char* file_name
	i32, ; uint32_t data_offset
	i32, ; uint32_t data_size
	ptr, ; uint8_t data
	i32, ; uint32_t name_length
	ptr ; char* name
}

; 0x25e6972616d58
@format_tag = dso_local local_unnamed_addr constant i64 666756936985944, align 8

@mono_aot_mode_name = dso_local local_unnamed_addr constant ptr @.env.0, align 8

; Application environment variables array, name:value
@app_environment_variables = dso_local local_unnamed_addr constant [4 x ptr] [
	ptr @.env.var.0, ; 0 ('MONO_GC_PARAMS')
	ptr @.env.var.1, ; 1 ('major=marksweep-conc')
	ptr @.env.var.2, ; 2 ('XA_HTTP_CLIENT_HANDLER_TYPE')
	ptr @.env.var.3 ; 3 ('Xamarin.Android.Net.AndroidMessageHandler')
], align 16

; System properties defined by the application
@app_system_properties = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 8

@application_config = dso_local local_unnamed_addr constant %struct.ApplicationConfig {
	i1 false, ; bool uses_mono_llvm
	i1 true, ; bool uses_mono_aot
	i1 true, ; bool aot_lazy_load
	i1 false, ; bool uses_assembly_preload
	i1 false, ; bool broken_exception_transitions
	i1 false, ; bool jni_add_native_method_registration_attribute_present
	i1 true, ; bool have_runtime_config_blob
	i1 true, ; bool have_assemblies_blob
	i1 true, ; bool marshal_methods_enabled
	i1 false, ; bool ignore_split_configs
	i8 0, ; uint8_t bound_stream_io_exception_type
	i32 3, ; uint32_t package_naming_policy
	i32 4, ; uint32_t environment_variable_count
	i32 0, ; uint32_t system_property_count
	i32 14, ; uint32_t number_of_assemblies_in_apk
	i32 0, ; uint32_t bundled_assembly_name_width
	i32 28, ; uint32_t number_of_dso_cache_entries
	i32 126, ; uint32_t number_of_aot_cache_entries
	i32 21, ; uint32_t number_of_shared_libraries
	i32 u0x020000ce, ; uint32_t android_runtime_jnienv_class_token
	i32 u0x060005b0, ; uint32_t jnienv_initialize_method_token
	i32 u0x060005af, ; uint32_t jnienv_registerjninatives_method_token
	i32 0, ; uint32_t jni_remapping_replacement_type_count
	i32 0, ; uint32_t jni_remapping_replacement_method_index_entry_count
	i32 u0x00000000, ; uint32_t mono_components_mask
	ptr @.ApplicationConfig.0_android_package_name, ; char* android_package_name
	i1 false; bool managed_marshal_methods_lookup_enabled
}, align 16

; DSO cache entries
@dso_cache = dso_local local_unnamed_addr global [28 x %struct.DSOCacheEntry] [
	%struct.DSOCacheEntry {
		i64 u0x01848c0093f0afd8, ; from name: libSystem.Security.Cryptography.Native.Android
		i64 u0x4818e42ca66bbd75, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 true, ; bool is_jni_library
		ptr @.DSOCacheEntry.3_name, ; name: libSystem.Security.Cryptography.Native.Android.so
		ptr null; void* handle
	}, ; 0
	%struct.DSOCacheEntry {
		i64 u0x04bb981b3c3ff40f, ; from name: System.Security.Cryptography.Native.Android.so
		i64 u0x4818e42ca66bbd75, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 true, ; bool is_jni_library
		ptr @.DSOCacheEntry.3_name, ; name: libSystem.Security.Cryptography.Native.Android.so
		ptr null; void* handle
	}, ; 1
	%struct.DSOCacheEntry {
		i64 u0x0582d422de762780, ; from name: libmono-component-marshal-ilgen.so
		i64 u0x0582d422de762780, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.4_name, ; name: libmono-component-marshal-ilgen.so
		ptr null; void* handle
	}, ; 2
	%struct.DSOCacheEntry {
		i64 u0x07e1516b937259a4, ; from name: System.Globalization.Native.so
		i64 u0x74b568291c419777, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.0_name, ; name: libSystem.Globalization.Native.so
		ptr null; void* handle
	}, ; 3
	%struct.DSOCacheEntry {
		i64 u0x1a1918dd01662b19, ; from name: libmonosgen-2.0.so
		i64 u0x1a1918dd01662b19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.5_name, ; name: libmonosgen-2.0.so
		ptr null; void* handle
	}, ; 4
	%struct.DSOCacheEntry {
		i64 u0x28b5c8fca080abd5, ; from name: libSystem.Globalization.Native
		i64 u0x74b568291c419777, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.0_name, ; name: libSystem.Globalization.Native.so
		ptr null; void* handle
	}, ; 5
	%struct.DSOCacheEntry {
		i64 u0x2b87bb6ac8822015, ; from name: libmonodroid
		i64 u0x4434c7fd110c8d8b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 true, ; bool is_jni_library
		ptr @.DSOCacheEntry.6_name, ; name: libmonodroid.so
		ptr null; void* handle
	}, ; 6
	%struct.DSOCacheEntry {
		i64 u0x3807dd20062deb45, ; from name: monodroid
		i64 u0x4434c7fd110c8d8b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 true, ; bool is_jni_library
		ptr @.DSOCacheEntry.6_name, ; name: libmonodroid.so
		ptr null; void* handle
	}, ; 7
	%struct.DSOCacheEntry {
		i64 u0x40f32024ffd1c0be, ; from name: System.IO.Compression.Native.so
		i64 u0xc3cb80650fe5a0ab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.1_name, ; name: libSystem.IO.Compression.Native.so
		ptr null; void* handle
	}, ; 8
	%struct.DSOCacheEntry {
		i64 u0x4434c7fd110c8d8b, ; from name: libmonodroid.so
		i64 u0x4434c7fd110c8d8b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 true, ; bool is_jni_library
		ptr @.DSOCacheEntry.6_name, ; name: libmonodroid.so
		ptr null; void* handle
	}, ; 9
	%struct.DSOCacheEntry {
		i64 u0x4818e42ca66bbd75, ; from name: libSystem.Security.Cryptography.Native.Android.so
		i64 u0x4818e42ca66bbd75, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 true, ; bool is_jni_library
		ptr @.DSOCacheEntry.3_name, ; name: libSystem.Security.Cryptography.Native.Android.so
		ptr null; void* handle
	}, ; 10
	%struct.DSOCacheEntry {
		i64 u0x4cd7bd0032e920e1, ; from name: libSystem.Native
		i64 u0xa337ccc8aef94267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.2_name, ; name: libSystem.Native.so
		ptr null; void* handle
	}, ; 11
	%struct.DSOCacheEntry {
		i64 u0x61c4cca6c77a9014, ; from name: libmonosgen-2.0
		i64 u0x1a1918dd01662b19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.5_name, ; name: libmonosgen-2.0.so
		ptr null; void* handle
	}, ; 12
	%struct.DSOCacheEntry {
		i64 u0x74b568291c419777, ; from name: libSystem.Globalization.Native.so
		i64 u0x74b568291c419777, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.0_name, ; name: libSystem.Globalization.Native.so
		ptr null; void* handle
	}, ; 13
	%struct.DSOCacheEntry {
		i64 u0x81bc2b0b52670f30, ; from name: System.Security.Cryptography.Native.Android
		i64 u0x4818e42ca66bbd75, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 true, ; bool is_jni_library
		ptr @.DSOCacheEntry.3_name, ; name: libSystem.Security.Cryptography.Native.Android.so
		ptr null; void* handle
	}, ; 14
	%struct.DSOCacheEntry {
		i64 u0x9190f4cb761b1d3c, ; from name: libSystem.IO.Compression.Native
		i64 u0xc3cb80650fe5a0ab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.1_name, ; name: libSystem.IO.Compression.Native.so
		ptr null; void* handle
	}, ; 15
	%struct.DSOCacheEntry {
		i64 u0x936d971cc035eac2, ; from name: mono-component-marshal-ilgen
		i64 u0x0582d422de762780, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.4_name, ; name: libmono-component-marshal-ilgen.so
		ptr null; void* handle
	}, ; 16
	%struct.DSOCacheEntry {
		i64 u0x9c62065cdbdf43a5, ; from name: monosgen-2.0
		i64 u0x1a1918dd01662b19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.5_name, ; name: libmonosgen-2.0.so
		ptr null; void* handle
	}, ; 17
	%struct.DSOCacheEntry {
		i64 u0x9ff54ae8a9311b68, ; from name: System.Native
		i64 u0xa337ccc8aef94267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.2_name, ; name: libSystem.Native.so
		ptr null; void* handle
	}, ; 18
	%struct.DSOCacheEntry {
		i64 u0xa337ccc8aef94267, ; from name: libSystem.Native.so
		i64 u0xa337ccc8aef94267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.2_name, ; name: libSystem.Native.so
		ptr null; void* handle
	}, ; 19
	%struct.DSOCacheEntry {
		i64 u0xa76ab5a3894f5a01, ; from name: System.Globalization.Native
		i64 u0x74b568291c419777, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.0_name, ; name: libSystem.Globalization.Native.so
		ptr null; void* handle
	}, ; 20
	%struct.DSOCacheEntry {
		i64 u0xab177aa6a32873ac, ; from name: monodroid.so
		i64 u0x4434c7fd110c8d8b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 true, ; bool is_jni_library
		ptr @.DSOCacheEntry.6_name, ; name: libmonodroid.so
		ptr null; void* handle
	}, ; 21
	%struct.DSOCacheEntry {
		i64 u0xc3cb80650fe5a0ab, ; from name: libSystem.IO.Compression.Native.so
		i64 u0xc3cb80650fe5a0ab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.1_name, ; name: libSystem.IO.Compression.Native.so
		ptr null; void* handle
	}, ; 22
	%struct.DSOCacheEntry {
		i64 u0xd334d108d628ab4f, ; from name: System.IO.Compression.Native
		i64 u0xc3cb80650fe5a0ab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.1_name, ; name: libSystem.IO.Compression.Native.so
		ptr null; void* handle
	}, ; 23
	%struct.DSOCacheEntry {
		i64 u0xd565cc57ed541a90, ; from name: monosgen-2.0.so
		i64 u0x1a1918dd01662b19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.5_name, ; name: libmonosgen-2.0.so
		ptr null; void* handle
	}, ; 24
	%struct.DSOCacheEntry {
		i64 u0xde6fb4b955d66724, ; from name: libmono-component-marshal-ilgen
		i64 u0x0582d422de762780, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.4_name, ; name: libmono-component-marshal-ilgen.so
		ptr null; void* handle
	}, ; 25
	%struct.DSOCacheEntry {
		i64 u0xe0d15587b4505ecd, ; from name: mono-component-marshal-ilgen.so
		i64 u0x0582d422de762780, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.4_name, ; name: libmono-component-marshal-ilgen.so
		ptr null; void* handle
	}, ; 26
	%struct.DSOCacheEntry {
		i64 u0xecb906ed9649ed1c, ; from name: System.Native.so
		i64 u0xa337ccc8aef94267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.2_name, ; name: libSystem.Native.so
		ptr null; void* handle
	} ; 27
], align 16

@dso_jni_preloads_idx_stride = dso_local local_unnamed_addr constant i32 4, align 4

@dso_jni_preloads_idx_count = dso_local local_unnamed_addr constant i64 4, align 8

; Indices into dso_cache[] of DSO libraries to preload because of JNI use
@dso_jni_preloads_idx = dso_local local_unnamed_addr constant [4 x i32] [
	i32 10, ; libSystem.Security.Cryptography.Native.Android.so
	i32 0, ; libSystem.Security.Cryptography.Native.Android
	i32 1, ; System.Security.Cryptography.Native.Android.so
	i32 14 ; System.Security.Cryptography.Native.Android
], align 16

; AOT DSO cache entries
@aot_dso_cache = dso_local local_unnamed_addr global [126 x %struct.DSOCacheEntry] [
	%struct.DSOCacheEntry {
		i64 u0x019ef78eca126b3d, ; from name: aot-Mono.Android.so
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.19_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 0
	%struct.DSOCacheEntry {
		i64 u0x02ce506e1a16ff6a, ; from name: aot-System.Collections.dll.so
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.9_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 1
	%struct.DSOCacheEntry {
		i64 u0x031aeea51ada0ffd, ; from name: aot-System.Threading
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.16_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 2
	%struct.DSOCacheEntry {
		i64 u0x05411110dc51e939, ; from name: libaot-System.Collections.so
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.9_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 3
	%struct.DSOCacheEntry {
		i64 u0x06de7ebf7e865e5c, ; from name: System.Private.CoreLib.so
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.20_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 4
	%struct.DSOCacheEntry {
		i64 u0x077be473fe3d3eef, ; from name: aot-Mono.Android.dll.so
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.19_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 5
	%struct.DSOCacheEntry {
		i64 u0x09d144a7e214d457, ; from name: System.Security.Cryptography
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.14_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 6
	%struct.DSOCacheEntry {
		i64 u0x0a147b2c00acff78, ; from name: aot-System.Collections
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.9_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 7
	%struct.DSOCacheEntry {
		i64 u0x0bbe9d20bf639a6d, ; from name: Mono.Android.dll.so
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.19_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 8
	%struct.DSOCacheEntry {
		i64 u0x0c59ad9fbbd43abe, ; from name: Mono.Android
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.19_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 9
	%struct.DSOCacheEntry {
		i64 u0x0c920480fa0c2eaa, ; from name: aot-System.Threading.dll.so
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.16_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 10
	%struct.DSOCacheEntry {
		i64 u0x0c95146e3fdcf631, ; from name: libaot-Mono.Android.so
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.19_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 11
	%struct.DSOCacheEntry {
		i64 u0x0dd6f35447704ccb, ; from name: aot-System.Private.CoreLib.dll.so
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.20_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 12
	%struct.DSOCacheEntry {
		i64 u0x0e85db2a1cd0e11a, ; from name: System.Threading.dll.so
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.16_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 13
	%struct.DSOCacheEntry {
		i64 u0x0ee139ab935710eb, ; from name: aot-Mono.Android.Runtime
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.18_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 14
	%struct.DSOCacheEntry {
		i64 u0x0f6ec7bc00b37705, ; from name: libaot-System.Runtime
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.13_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 15
	%struct.DSOCacheEntry {
		i64 u0x13e4c9b4a68b70b1, ; from name: aot-System.Linq
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.11_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 16
	%struct.DSOCacheEntry {
		i64 u0x14509a44f2bd8f81, ; from name: System.Console.dll.so
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.10_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 17
	%struct.DSOCacheEntry {
		i64 u0x14c874ac8b04a442, ; from name: aot-System.Runtime.InteropServices.so
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.12_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 18
	%struct.DSOCacheEntry {
		i64 u0x156ae2b2e8a39884, ; from name: libaot-Mono.Android.Runtime.dll.so
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.18_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 19
	%struct.DSOCacheEntry {
		i64 u0x1e821bd8427d5c24, ; from name: aot-System.Runtime.InteropServices
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.12_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 20
	%struct.DSOCacheEntry {
		i64 u0x2174319c0d835bc9, ; from name: System.Runtime
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.13_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 21
	%struct.DSOCacheEntry {
		i64 u0x22626c401e88babc, ; from name: libaot-System.Threading.Thread
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.15_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 22
	%struct.DSOCacheEntry {
		i64 u0x2407aef2bbe8fadf, ; from name: System.Console
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.10_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 23
	%struct.DSOCacheEntry {
		i64 u0x2c3037a6cc5d862d, ; from name: aot-Mono.Android.Runtime.so
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.18_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 24
	%struct.DSOCacheEntry {
		i64 u0x2ef2ce6dde531f65, ; from name: aot-System.Threading.Thread
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.15_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 25
	%struct.DSOCacheEntry {
		i64 u0x2fb7a3952b307fae, ; from name: libaot-System.Linq.dll.so
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.11_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 26
	%struct.DSOCacheEntry {
		i64 u0x322ac199914afc70, ; from name: aot-System.Collections.so
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.9_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 27
	%struct.DSOCacheEntry {
		i64 u0x3304b4516332575c, ; from name: System.Collections.dll.so
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.9_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 28
	%struct.DSOCacheEntry {
		i64 u0x359895a3c1bd5685, ; from name: libaot-Mono.Android.dll.so
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.19_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 29
	%struct.DSOCacheEntry {
		i64 u0x391aa2415ba790ce, ; from name: aot-wallpaperTrade
		i64 u0x838f569dea1473bb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.8_name, ; name: libaot-wallpaperTrade.dll.so
		ptr null; void* handle
	}, ; 30
	%struct.DSOCacheEntry {
		i64 u0x39724e27f46db55d, ; from name: libaot-Mono.Android.Runtime
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.18_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 31
	%struct.DSOCacheEntry {
		i64 u0x4369960919e5e6e9, ; from name: libaot-System.Threading.Thread.so
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.15_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 32
	%struct.DSOCacheEntry {
		i64 u0x46fe6fb82f79008c, ; from name: libaot-Java.Interop.so
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.17_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 33
	%struct.DSOCacheEntry {
		i64 u0x4ac13f7cd8a4fac3, ; from name: wallpaperTrade
		i64 u0x838f569dea1473bb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.8_name, ; name: libaot-wallpaperTrade.dll.so
		ptr null; void* handle
	}, ; 34
	%struct.DSOCacheEntry {
		i64 u0x4e32f00cb0937401, ; from name: Mono.Android.Runtime
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.18_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 35
	%struct.DSOCacheEntry {
		i64 u0x50f8d125d8dd00cf, ; from name: libaot-System.Console
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.10_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 36
	%struct.DSOCacheEntry {
		i64 u0x5424938e04124349, ; from name: aot-System.Private.CoreLib
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.20_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 37
	%struct.DSOCacheEntry {
		i64 u0x5715f89db0aca1ea, ; from name: libaot-System.Runtime.InteropServices.so
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.12_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 38
	%struct.DSOCacheEntry {
		i64 u0x579f7955a9783e96, ; from name: System.Linq.so
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.11_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 39
	%struct.DSOCacheEntry {
		i64 u0x57ffa7cfb0f0bb01, ; from name: libaot-wallpaperTrade.so
		i64 u0x838f569dea1473bb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.8_name, ; name: libaot-wallpaperTrade.dll.so
		ptr null; void* handle
	}, ; 40
	%struct.DSOCacheEntry {
		i64 u0x5ae6db1ddadc230b, ; from name: libaot-System.Runtime.InteropServices.dll.so
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.12_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 41
	%struct.DSOCacheEntry {
		i64 u0x5bf0c23bdb13c0d6, ; from name: libaot-System.Security.Cryptography.so
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.14_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 42
	%struct.DSOCacheEntry {
		i64 u0x5d27b7bc45f3b602, ; from name: aot-wallpaperTrade.so
		i64 u0x838f569dea1473bb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.8_name, ; name: libaot-wallpaperTrade.dll.so
		ptr null; void* handle
	}, ; 43
	%struct.DSOCacheEntry {
		i64 u0x5f435aa7f5fde870, ; from name: libaot-System.Threading.dll.so
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.16_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 44
	%struct.DSOCacheEntry {
		i64 u0x622eef6f9e59068d, ; from name: System.Private.CoreLib
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.20_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 45
	%struct.DSOCacheEntry {
		i64 u0x6250af18a9734a88, ; from name: aot-System.Console.so
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.10_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 46
	%struct.DSOCacheEntry {
		i64 u0x64124dac20f9924e, ; from name: libaot-System.Security.Cryptography
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.14_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 47
	%struct.DSOCacheEntry {
		i64 u0x64be874ebbce6bd2, ; from name: aot-System.Private.CoreLib.so
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.20_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 48
	%struct.DSOCacheEntry {
		i64 u0x654a1612f95f8409, ; from name: aot-_Microsoft.Android.Resource.Designer.dll.so
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.7_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 49
	%struct.DSOCacheEntry {
		i64 u0x675935a1e3b604dc, ; from name: libaot-System.Threading.Thread.dll.so
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.15_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 50
	%struct.DSOCacheEntry {
		i64 u0x67afd0bf45d8aeec, ; from name: libaot-System.Threading
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.16_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 51
	%struct.DSOCacheEntry {
		i64 u0x69f8bcaead2613c0, ; from name: System.Runtime.InteropServices.so
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.12_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 52
	%struct.DSOCacheEntry {
		i64 u0x6a039c1f557cc435, ; from name: System.Collections.so
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.9_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 53
	%struct.DSOCacheEntry {
		i64 u0x6b191693b6226982, ; from name: Mono.Android.so
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.19_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 54
	%struct.DSOCacheEntry {
		i64 u0x6ce045494a545eab, ; from name: libaot-Java.Interop.dll.so
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.17_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 55
	%struct.DSOCacheEntry {
		i64 u0x72390be79b9026fa, ; from name: libaot-System.Console.so
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.10_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 56
	%struct.DSOCacheEntry {
		i64 u0x764e09afb7f22c1f, ; from name: libaot-System.Private.CoreLib
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.20_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 57
	%struct.DSOCacheEntry {
		i64 u0x7adcf889f929072e, ; from name: libaot-Mono.Android.Runtime.so
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.18_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 58
	%struct.DSOCacheEntry {
		i64 u0x7dec6152c2473976, ; from name: libaot-_Microsoft.Android.Resource.Designer.so
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.7_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 59
	%struct.DSOCacheEntry {
		i64 u0x7dfc3d6d9d8d7b70, ; from name: System.Collections
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.9_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 60
	%struct.DSOCacheEntry {
		i64 u0x7edbb351f3f9be56, ; from name: libaot-System.Private.CoreLib.so
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.20_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 61
	%struct.DSOCacheEntry {
		i64 u0x7fb3d22a29fb88db, ; from name: _Microsoft.Android.Resource.Designer.dll.so
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.7_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 62
	%struct.DSOCacheEntry {
		i64 u0x81b24cdb39c8ef28, ; from name: wallpaperTrade.so
		i64 u0x838f569dea1473bb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.8_name, ; name: libaot-wallpaperTrade.dll.so
		ptr null; void* handle
	}, ; 63
	%struct.DSOCacheEntry {
		i64 u0x82a2e2148ec96b41, ; from name: libaot-System.Linq.so
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.11_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 64
	%struct.DSOCacheEntry {
		i64 u0x838f569dea1473bb, ; from name: libaot-wallpaperTrade.dll.so
		i64 u0x838f569dea1473bb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.8_name, ; name: libaot-wallpaperTrade.dll.so
		ptr null; void* handle
	}, ; 65
	%struct.DSOCacheEntry {
		i64 u0x858cd519f13e3ea3, ; from name: aot-System.Security.Cryptography
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.14_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 66
	%struct.DSOCacheEntry {
		i64 u0x87e71d68120b9580, ; from name: aot-Java.Interop.dll.so
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.17_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 67
	%struct.DSOCacheEntry {
		i64 u0x8ab573a2f264ef6e, ; from name: libaot-Java.Interop
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.17_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 68
	%struct.DSOCacheEntry {
		i64 u0x8d7b8ab4b3310ead, ; from name: System.Threading
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.16_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 69
	%struct.DSOCacheEntry {
		i64 u0x903101b46fb73a04, ; from name: _Microsoft.Android.Resource.Designer
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.7_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 70
	%struct.DSOCacheEntry {
		i64 u0x9527948cf7bb1991, ; from name: libaot-System.Threading.so
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.16_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 71
	%struct.DSOCacheEntry {
		i64 u0x956f26e96f96282b, ; from name: Mono.Android.Runtime.so
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.18_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 72
	%struct.DSOCacheEntry {
		i64 u0x96753d66e2619fc0, ; from name: aot-System.Security.Cryptography.dll.so
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.14_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 73
	%struct.DSOCacheEntry {
		i64 u0x974ab92bce1b2c8e, ; from name: wallpaperTrade.dll.so
		i64 u0x838f569dea1473bb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.8_name, ; name: libaot-wallpaperTrade.dll.so
		ptr null; void* handle
	}, ; 74
	%struct.DSOCacheEntry {
		i64 u0x97529a82db270486, ; from name: aot-System.Runtime.InteropServices.dll.so
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.12_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 75
	%struct.DSOCacheEntry {
		i64 u0x984a5bf1c8ad2a21, ; from name: libaot-System.Runtime.so
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.13_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 76
	%struct.DSOCacheEntry {
		i64 u0x99e783e6676e7adf, ; from name: System.Runtime.InteropServices.dll.so
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.12_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 77
	%struct.DSOCacheEntry {
		i64 u0x9a6f648da172667e, ; from name: _Microsoft.Android.Resource.Designer.so
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.7_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 78
	%struct.DSOCacheEntry {
		i64 u0x9cbca1c74026e295, ; from name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.7_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 79
	%struct.DSOCacheEntry {
		i64 u0x9cbd1d72a9e5192f, ; from name: System.Runtime.dll.so
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.13_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 80
	%struct.DSOCacheEntry {
		i64 u0x9f473a65f10d6fa9, ; from name: aot-System.Console
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.10_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 81
	%struct.DSOCacheEntry {
		i64 u0xa36762ce482f6584, ; from name: Java.Interop.so
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.17_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 82
	%struct.DSOCacheEntry {
		i64 u0xa57746d2a371c785, ; from name: aot-System.Runtime.so
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.13_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 83
	%struct.DSOCacheEntry {
		i64 u0xa6d29cffa841bf87, ; from name: Mono.Android.Runtime.dll.so
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.18_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 84
	%struct.DSOCacheEntry {
		i64 u0xa99fc710fdd6e008, ; from name: System.Threading.so
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.16_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 85
	%struct.DSOCacheEntry {
		i64 u0xae282bcd03739de7, ; from name: Java.Interop
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.17_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 86
	%struct.DSOCacheEntry {
		i64 u0xb2d0ce1b008afb2a, ; from name: libaot-System.Linq
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.11_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 87
	%struct.DSOCacheEntry {
		i64 u0xb3f9fc836ae7ebb5, ; from name: libaot-System.Collections.dll.so
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.9_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 88
	%struct.DSOCacheEntry {
		i64 u0xb48e9e71b06b9446, ; from name: aot-Mono.Android
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.19_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 89
	%struct.DSOCacheEntry {
		i64 u0xb71bb9a8d392fa40, ; from name: System.Linq.dll.so
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.11_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 90
	%struct.DSOCacheEntry {
		i64 u0xb7879ed14a810ab4, ; from name: Java.Interop.dll.so
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.17_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 91
	%struct.DSOCacheEntry {
		i64 u0xb88aaf70962c6080, ; from name: aot-System.Linq.dll.so
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.11_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 92
	%struct.DSOCacheEntry {
		i64 u0xb8c4e6d79b2bf900, ; from name: System.Private.CoreLib.dll.so
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.20_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 93
	%struct.DSOCacheEntry {
		i64 u0xbbc0e6e747d7877a, ; from name: libaot-System.Runtime.dll.so
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.13_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 94
	%struct.DSOCacheEntry {
		i64 u0xc2b46ace5ffdf725, ; from name: aot-Java.Interop.so
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.17_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 95
	%struct.DSOCacheEntry {
		i64 u0xc2da5dca6ccd8b0a, ; from name: libaot-System.Console.dll.so
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.10_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 96
	%struct.DSOCacheEntry {
		i64 u0xcb0c13d562c0b850, ; from name: libaot-_Microsoft.Android.Resource.Designer
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.7_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 97
	%struct.DSOCacheEntry {
		i64 u0xcca5b1eb1cdf4b7d, ; from name: aot-System.Threading.Thread.so
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.15_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 98
	%struct.DSOCacheEntry {
		i64 u0xd0e82017367ac826, ; from name: libaot-System.Security.Cryptography.dll.so
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.14_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 99
	%struct.DSOCacheEntry {
		i64 u0xd2475965a9e31837, ; from name: aot-System.Threading.so
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.16_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 100
	%struct.DSOCacheEntry {
		i64 u0xd333d0af9e423810, ; from name: System.Runtime.InteropServices
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.12_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 101
	%struct.DSOCacheEntry {
		i64 u0xd4d27f08b1450804, ; from name: System.Runtime.so
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.13_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 102
	%struct.DSOCacheEntry {
		i64 u0xd52767571e1f65af, ; from name: aot-System.Runtime.dll.so
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.13_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 103
	%struct.DSOCacheEntry {
		i64 u0xd7845c8bf07d04e9, ; from name: aot-System.Console.dll.so
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.10_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 104
	%struct.DSOCacheEntry {
		i64 u0xd788c113da082c63, ; from name: libaot-Mono.Android
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.19_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 105
	%struct.DSOCacheEntry {
		i64 u0xd8b23283eb26ad3e, ; from name: aot-System.Linq.so
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.11_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 106
	%struct.DSOCacheEntry {
		i64 u0xda3e671b21710f18, ; from name: aot-Java.Interop
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.17_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 107
	%struct.DSOCacheEntry {
		i64 u0xdbf9607a441b4505, ; from name: System.Linq
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.11_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 108
	%struct.DSOCacheEntry {
		i64 u0xde5702cd751b5645, ; from name: System.Security.Cryptography.so
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.14_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 109
	%struct.DSOCacheEntry {
		i64 u0xe106423bc739c2b2, ; from name: aot-_Microsoft.Android.Resource.Designer.so
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.7_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 110
	%struct.DSOCacheEntry {
		i64 u0xe125cb42da1b888c, ; from name: aot-System.Security.Cryptography.so
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.14_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 111
	%struct.DSOCacheEntry {
		i64 u0xe1af59ffe15719e2, ; from name: libaot-System.Private.CoreLib.dll.so
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.20_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 112
	%struct.DSOCacheEntry {
		i64 u0xe456dd9cd8a3e128, ; from name: System.Security.Cryptography.dll.so
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.14_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 113
	%struct.DSOCacheEntry {
		i64 u0xe7fb811d00b98871, ; from name: aot-System.Runtime
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.13_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 114
	%struct.DSOCacheEntry {
		i64 u0xe9d8af3418a9d0ab, ; from name: aot-wallpaperTrade.dll.so
		i64 u0x838f569dea1473bb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.8_name, ; name: libaot-wallpaperTrade.dll.so
		ptr null; void* handle
	}, ; 115
	%struct.DSOCacheEntry {
		i64 u0xeb2eb87760c7a2f5, ; from name: libaot-System.Collections
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.9_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 116
	%struct.DSOCacheEntry {
		i64 u0xec55cf28d070093e, ; from name: libaot-wallpaperTrade
		i64 u0x838f569dea1473bb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.8_name, ; name: libaot-wallpaperTrade.dll.so
		ptr null; void* handle
	}, ; 117
	%struct.DSOCacheEntry {
		i64 u0xecd78ed4818f3e83, ; from name: System.Threading.Thread.so
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.15_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 118
	%struct.DSOCacheEntry {
		i64 u0xed4191e57023378a, ; from name: aot-Mono.Android.Runtime.dll.so
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.18_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 119
	%struct.DSOCacheEntry {
		i64 u0xed46da2e8bc1b60c, ; from name: libaot-System.Runtime.InteropServices
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.12_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 120
	%struct.DSOCacheEntry {
		i64 u0xf4fa59b00364ce58, ; from name: aot-_Microsoft.Android.Resource.Designer
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.7_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 121
	%struct.DSOCacheEntry {
		i64 u0xf5e5ace884bd7ee0, ; from name: System.Console.so
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.10_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 122
	%struct.DSOCacheEntry {
		i64 u0xf9f2b80dd027f4bc, ; from name: aot-System.Threading.Thread.dll.so
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.15_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 123
	%struct.DSOCacheEntry {
		i64 u0xfa645d91e9fc4cba, ; from name: System.Threading.Thread
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.15_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 124
	%struct.DSOCacheEntry {
		i64 u0xfb641158a5aae610, ; from name: System.Threading.Thread.dll.so
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		i1 false, ; bool is_jni_library
		ptr @.DSOCacheEntry.15_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	} ; 125
], align 16

@dso_apk_entries = dso_local local_unnamed_addr global [21 x %struct.DSOApkEntry] zeroinitializer, align 16

; Bundled assembly name buffers, all empty (unused when assembly stores are enabled)
@bundled_assemblies = dso_local local_unnamed_addr global [0 x %struct.XamarinAndroidBundledAssembly] zeroinitializer, align 8

@assembly_store_bundled_assemblies = dso_local local_unnamed_addr global [14 x %struct.AssemblyStoreSingleAssemblyRuntimeData] zeroinitializer, align 8

@assembly_store = dso_local local_unnamed_addr global %struct.AssemblyStoreRuntimeData {
	ptr null, ; uint8_t* data_start
	i32 0, ; uint32_t assembly_count
	i32 0, ; uint32_t index_entry_count
	ptr null; AssemblyStoreAssemblyDescriptor* assemblies
}, align 8

; Strings
@.env.0 = private unnamed_addr constant [7 x i8] c"normal\00", align 1

; Application environment variables name:value pairs
@.env.var.0 = private unnamed_addr constant [15 x i8] c"MONO_GC_PARAMS\00", align 1
@.env.var.1 = private unnamed_addr constant [21 x i8] c"major=marksweep-conc\00", align 16
@.env.var.2 = private unnamed_addr constant [28 x i8] c"XA_HTTP_CLIENT_HANDLER_TYPE\00", align 16
@.env.var.3 = private unnamed_addr constant [42 x i8] c"Xamarin.Android.Net.AndroidMessageHandler\00", align 16

;ApplicationConfig
@.ApplicationConfig.0_android_package_name = private unnamed_addr constant [23 x i8] c"com.dsc.WallpaperTrade\00", align 16

;DSOCacheEntry
@.DSOCacheEntry.0_name = private unnamed_addr constant [34 x i8] c"libSystem.Globalization.Native.so\00", align 16
@.DSOCacheEntry.1_name = private unnamed_addr constant [35 x i8] c"libSystem.IO.Compression.Native.so\00", align 16
@.DSOCacheEntry.2_name = private unnamed_addr constant [20 x i8] c"libSystem.Native.so\00", align 16
@.DSOCacheEntry.3_name = private unnamed_addr constant [50 x i8] c"libSystem.Security.Cryptography.Native.Android.so\00", align 16
@.DSOCacheEntry.4_name = private unnamed_addr constant [35 x i8] c"libmono-component-marshal-ilgen.so\00", align 16
@.DSOCacheEntry.5_name = private unnamed_addr constant [19 x i8] c"libmonosgen-2.0.so\00", align 16
@.DSOCacheEntry.6_name = private unnamed_addr constant [16 x i8] c"libmonodroid.so\00", align 16
@.DSOCacheEntry.7_name = private unnamed_addr constant [51 x i8] c"libaot-_Microsoft.Android.Resource.Designer.dll.so\00", align 16
@.DSOCacheEntry.8_name = private unnamed_addr constant [29 x i8] c"libaot-wallpaperTrade.dll.so\00", align 16
@.DSOCacheEntry.9_name = private unnamed_addr constant [33 x i8] c"libaot-System.Collections.dll.so\00", align 16
@.DSOCacheEntry.10_name = private unnamed_addr constant [29 x i8] c"libaot-System.Console.dll.so\00", align 16
@.DSOCacheEntry.11_name = private unnamed_addr constant [26 x i8] c"libaot-System.Linq.dll.so\00", align 16
@.DSOCacheEntry.12_name = private unnamed_addr constant [45 x i8] c"libaot-System.Runtime.InteropServices.dll.so\00", align 16
@.DSOCacheEntry.13_name = private unnamed_addr constant [29 x i8] c"libaot-System.Runtime.dll.so\00", align 16
@.DSOCacheEntry.14_name = private unnamed_addr constant [43 x i8] c"libaot-System.Security.Cryptography.dll.so\00", align 16
@.DSOCacheEntry.15_name = private unnamed_addr constant [38 x i8] c"libaot-System.Threading.Thread.dll.so\00", align 16
@.DSOCacheEntry.16_name = private unnamed_addr constant [31 x i8] c"libaot-System.Threading.dll.so\00", align 16
@.DSOCacheEntry.17_name = private unnamed_addr constant [27 x i8] c"libaot-Java.Interop.dll.so\00", align 16
@.DSOCacheEntry.18_name = private unnamed_addr constant [35 x i8] c"libaot-Mono.Android.Runtime.dll.so\00", align 16
@.DSOCacheEntry.19_name = private unnamed_addr constant [27 x i8] c"libaot-Mono.Android.dll.so\00", align 16
@.DSOCacheEntry.20_name = private unnamed_addr constant [37 x i8] c"libaot-System.Private.CoreLib.dll.so\00", align 16

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
