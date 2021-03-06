_help = help


class Lazy(object):
    def __init__(self, fn):
        self._fn = fn
        self._obj = None

    def _load_lazy(self):
        if self._obj is None:
            self._obj = self._fn()
            assert self._obj is not None

    def __getattr__(self, name):
        self._load_lazy()
        return getattr(self._obj, name)

    def __dir__(self):
        self._load_lazy()
        return dir(self._obj)

    def help(self):
        _help(self._obj)


class Autoloader(Lazy):
    def __init__(self, module_name):
        super(Autoloader, self).__init__(self._load_module)
        self.__module_name = module_name

    def _load_module(self):
        return __import__(self.__module_name)


def help(x):
    if isinstance(x, Autoloader):
        x._load_module()
        x.help()
    else:
        _help(x)

ast = Autoloader('ast')
chainer = Autoloader('chainer')
chx = Autoloader('chainerx')
cupy = Autoloader('cupy')
cv2 = Autoloader('cv2')
gast = Autoloader('gast')
glob = Autoloader('glob')
inspect = Autoloader('inspect')
json = Autoloader('json')
math = Autoloader('math')
matplotlib = Autoloader('matplotlib')
mock = Autoloader('mock')
multiprocessing = Autoloader('multiprocessing')
mxnet = Autoloader('mxnet')
ngraph = Autoloader('ngraph')
ngraph_onnx = Autoloader('ngraph_onnx')
nnvm = Autoloader('nnvm')
np = Autoloader('numpy')
onnx = Autoloader('onnx')
onnxruntime = Autoloader('onnxruntime')
onnx_chainer = Autoloader('onnx_chainer')
os = Autoloader('os')
re = Autoloader('re')
shutil = Autoloader('shutil')
struct = Autoloader('struct')
subprocess = Autoloader('subprocess')
sys = Autoloader('sys')
threading = Autoloader('threading')
tf = Autoloader('tensorflow')
torch = Autoloader('torch')
topi = Autoloader('topi')
tvm = Autoloader('tvm')
types = Autoloader('types')

F = Lazy(lambda: chainer.functions)
L = Lazy(lambda: chainer.links)