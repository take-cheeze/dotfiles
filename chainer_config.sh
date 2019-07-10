# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH="$HOME/.rbenv/bin:$GOPATH/bin:$HOME/.yarn/bin:$HOME/.cargo/bin:/usr/lib/ccache:/usr/local/go/bin:$HOME/bin:$PATH"

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export LD_LIBRARY_PATH="$HOME/.cudnn/active/cuda/lib64:$LD_LIBRARY_PATH"
export CPATH="$HOME/.cudnn/active/cuda/include:$CPATH"
export LIBRARY_PATH="$HOME/.cudnn/active/cuda/lib64:$LIBRARY_PATH"

export PATH=$PATH:/opt/rocm/bin:/opt/rocm/profiler/bin:/opt/rocm/opencl/bin/x86_64
export CHAINERX_NVCC_GENERATE_CODE="arch=compute_75,code=sm_75"

# export CUDNN_LOGDEST_DBG=stderr
# export CUDNN_LOGINFO_DBG=1
export CUDNN_ROOT_DIR=$HOME/.cudnn/active
export CHAINER_BUILD_CHAINERX=1 CHAINERX_BUILD_CUDA=1 CHAINERX_ENABLE_BLAS=1

# export LD_PRELOAD="$LD_PRELOAD:/usr/lib/x86_64-linux-gnu/libasan.so.5"
# export ASAN_OPTIONS="detect_leaks=0,protect_shadow_gap=0"
# export LSAN_OPTIONS="exitcode=0"

#  cd ~/dev/chainer-compiler && rm -rf build && mkdir build && cd build && cmake -DCHAINER_COMPILER_ENABLE_CUDA=ON -DCHAINER_COMPILER_ENABLE_PYTHON=ON -DCHAINER_COMPILER_ENABLE_CUDNN=ON -DCUDNN_ROOT_DIR=$HOME/.cudnn/active/cuda -DCHAINER_COMPILER_ENABLE_OPENCV=ON -DCMAKE_BUILD_TYPE=Debug -G Ninja ..

