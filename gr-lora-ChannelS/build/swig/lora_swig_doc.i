
/*
 * This file was automatically generated using swig_doc.py.
 *
 * Any changes to it will be lost next time it is regenerated.
 */




%feature("docstring") gr::lora::decode "<+description of block+>"

%feature("docstring") gr::lora::decode::make "Return a shared_ptr to a new instance of lora::decode.

To avoid accidental use of raw pointers, lora::decode's constructor is in a private implementation class. lora::decode::make is the public interface for creating new instances.

Params: (spreading_factor, code_rate, low_data_rate, header)"

%feature("docstring") gr::lora::demod "<+description of block+>"

%feature("docstring") gr::lora::demod::make "Return a shared_ptr to a new instance of lora::demod.

To avoid accidental use of raw pointers, lora::demod's constructor is in a private implementation class. lora::demod::make is the public interface for creating new instances.

Params: (spreading_factor, low_data_rate, beta, fft_factor)"

%feature("docstring") gr::lora::encode "<+description of block+>"

%feature("docstring") gr::lora::encode::make "Return a shared_ptr to a new instance of lora::encode.

To avoid accidental use of raw pointers, lora::encode's constructor is in a private implementation class. lora::encode::make is the public interface for creating new instances.

Params: (spreading_factor, code_rate, low_data_rate, header)"

%feature("docstring") gr::lora::mod "<+description of block+>"

%feature("docstring") gr::lora::mod::make "Return a shared_ptr to a new instance of lora::mod.

To avoid accidental use of raw pointers, lora::mod's constructor is in a private implementation class. lora::mod::make is the public interface for creating new instances.

Params: (spreading_factor, d_sync_word)"