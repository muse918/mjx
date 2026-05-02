from importlib.util import find_spec
from pathlib import Path


_HAS_MJX_EXT = find_spec("_mjx") is not None
_HAS_JAX = find_spec("jax") is not None


def pytest_ignore_collect(collection_path: Path, path=None, config=None):
    target = str(collection_path)

    excluded_fragments = ("pb2", "main.py", "pybind11", "external")
    if any(fragment in target for fragment in excluded_fragments):
        return True

    if "workspace/suphx-reward-shaping/tests" in target and not _HAS_JAX:
        return True

    if "tests_py" in target and not _HAS_MJX_EXT:
        return True

    return False
