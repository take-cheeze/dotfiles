if which direnv 2>/dev/null >/dev/null; then
    eval "$(direnv hook bash)"

    show_virtual_env() {
        if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
            echo "($(basename $VIRTUAL_ENV))"
        fi
    }
    export -f show_virtual_env
    PS1='$(show_virtual_env)'$PS1
fi

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

if ! which conda ; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

export PATH=$PATH:/opt/rocm/bin:/opt/rocm/profiler/bin:/opt/rocm/opencl/bin/x86_64
export CHAINERX_NVCC_GENERATE_CODE="arch=compute_75,code=sm_75"

# export CUDNN_LOGDEST_DBG=stderr
# export CUDNN_LOGINFO_DBG=1
export CHAINER_BUILD_CHAINERX=1 CHAINERX_BUILD_CUDA=1 CHAINERX_ENABLE_BLAS=1

export SNPE_ROOT="$HOME/dev/snpe/snpe-1.30.0.480"
export LD_LIBRARY_PATH="$SNPE_ROOT/lib/x86_64-linux-clang:$LD_LIBRARY_PATH"

# export LD_PRELOAD="$LD_PRELOAD:/usr/lib/x86_64-linux-gnu/libasan.so.5"
# export ASAN_OPTIONS="detect_leaks=0,protect_shadow_gap=0"
# export LSAN_OPTIONS="exitcode=0"

# cd ~/dev/chainer-compiler && rm -rf build && mkdir build && cd build && cmake -DCHAINER_COMPILER_ENABLE_CUDA=ON -DCHAINER_COMPILER_ENABLE_PYTHON=ON -DCHAINER_COMPILER_ENABLE_CUDNN=ON -DPYTHON_EXECUTABLE=$(which python) -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda -DCHAINER_COMPILER_ENABLE_OPENCV=ON -DCHAINER_COMPILER_ENABLE_OPENMP=ON -DCHAINER_COMPILER_ENABLE_TVM=ON -DCHAINER_COMPILER_ENABLE_TENSORRT=ON -G Ninja ..
# cd ~/dev/chainer/chainerx_cc && rm -rf build && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DCHAINERX_BUILD_CUDA=ON -DCHAINERX_BUILD_TEST=ON -DCHAINERX_BUILD_PYTHON=OFF -DCHAINERX_WARNINGS_AS_ERRORS=ON ..
