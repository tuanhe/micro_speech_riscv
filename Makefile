PROJECT = micro_speech

CROSS_COMPILE ?= riscv64-unknown-elf

# If users don't specify RISCV_PATH then assume that the tools will just be in
# their path.
RISCV_GCC     := $(abspath $(RISCV_PATH)/bin/$(CROSS_COMPILE)-gcc)
RISCV_GXX     := $(abspath $(RISCV_PATH)/bin/$(CROSS_COMPILE)-g++)
RISCV_OBJDUMP := $(abspath $(RISCV_PATH)/bin/$(CROSS_COMPILE)-objdump)
RISCV_OBJCOPY := $(abspath $(RISCV_PATH)/bin/$(CROSS_COMPILE)-objcopy)
RISCV_GDB     := $(abspath $(RISCV_PATH)/bin/$(CROSS_COMPILE)-gdb)
RISCV_AR      := $(abspath $(RISCV_PATH)/bin/$(CROSS_COMPILE)-ar)
RISCV_SIZE    := $(abspath $(RISCV_PATH)/bin/$(CROSS_COMPILE)-size)
#### micro speech test #####
#SRCS := \
tensorflow/lite/experimental/micro/micro_error_reporter.cc tensorflow/lite/experimental/micro/micro_mutable_op_resolver.cc tensorflow/lite/experimental/micro/simple_tensor_allocator.cc tensorflow/lite/experimental/micro/debug_log.cc tensorflow/lite/experimental/micro/debug_log_numbers.cc tensorflow/lite/experimental/micro/micro_interpreter.cc tensorflow/lite/experimental/micro/kernels/depthwise_conv.cc tensorflow/lite/experimental/micro/kernels/softmax.cc tensorflow/lite/experimental/micro/kernels/all_ops_resolver.cc tensorflow/lite/experimental/micro/kernels/fully_connected.cc tensorflow/lite/c/c_api_internal.c tensorflow/lite/core/api/error_reporter.cc tensorflow/lite/core/api/flatbuffer_conversions.cc tensorflow/lite/core/api/op_resolver.cc tensorflow/lite/kernels/kernel_util.cc tensorflow/lite/kernels/internal/quantization_util.cc  tensorflow/lite/experimental/micro/examples/micro_speech/main.cc tensorflow/lite/experimental/micro/examples/micro_speech/model_settings.cc tensorflow/lite/experimental/micro/examples/micro_speech/audio_provider.cc tensorflow/lite/experimental/micro/examples/micro_speech/feature_provider.cc tensorflow/lite/experimental/micro/examples/micro_speech/preprocessor.cc tensorflow/lite/experimental/micro/examples/micro_speech/no_features_data.cc tensorflow/lite/experimental/micro/examples/micro_speech/yes_features_data.cc tensorflow/lite/experimental/micro/examples/micro_speech/tiny_conv_model_data.cc tensorflow/lite/experimental/micro/examples/micro_speech/recognize_commands.cc

#### micro speech test #####
SRCS := \
tensorflow/lite/experimental/micro/micro_error_reporter.cc tensorflow/lite/experimental/micro/micro_mutable_op_resolver.cc tensorflow/lite/experimental/micro/simple_tensor_allocator.cc tensorflow/lite/experimental/micro/debug_log.cc tensorflow/lite/experimental/micro/debug_log_numbers.cc tensorflow/lite/experimental/micro/micro_interpreter.cc tensorflow/lite/experimental/micro/kernels/depthwise_conv.cc tensorflow/lite/experimental/micro/kernels/softmax.cc tensorflow/lite/experimental/micro/kernels/all_ops_resolver.cc tensorflow/lite/experimental/micro/kernels/fully_connected.cc tensorflow/lite/c/c_api_internal.c tensorflow/lite/core/api/error_reporter.cc tensorflow/lite/core/api/flatbuffer_conversions.cc tensorflow/lite/core/api/op_resolver.cc tensorflow/lite/kernels/kernel_util.cc tensorflow/lite/kernels/internal/quantization_util.cc  tensorflow/lite/experimental/micro/examples/micro_speech/micro_speech_test_wrapper.cc tensorflow/lite/experimental/micro/examples/micro_speech/tiny_conv_model_data.cc tensorflow/lite/experimental/micro/examples/micro_speech/no_features_data.cc tensorflow/lite/experimental/micro/examples/micro_speech/yes_features_data.cc

OBJS := \
$(patsubst %.cc,%.o,$(patsubst %.c,%.o,$(SRCS)))

LIB :=lib$(PROJECT).a 

INCLUDES := \
-I. \
-I./third_party/gemmlowp \
-I./third_party/flatbuffers/include

CXXFLAGS += -O3 -DNDEBUG --std=c++11 -g -DTF_LITE_STATIC_MEMORY  -march=rv32imac -mabi=ilp32 -mcmodel=medlow 
CCFLAGS += -march=rv32imac -mabi=ilp32 -mcmodel=medlow 
LDFLAGS += -lm

%.o: %.cc
	$(RISCV_GXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

%.o: %.c
	$(RISCV_GCC) $(CCFLAGS) $(INCLUDES) -c $< -o $@

#micro_speech : $(OBJS)
#	$(CXX) $(LDFLAGS) $(OBJS) \
	-o $@

#all: micro_speech

$(LIB) : $(OBJS)
	$(RISCV_AR) crs $@ $(OBJS) 

.PHONY : clean
clean :
	-rm $(OBJS)
	rm $(LIB)
