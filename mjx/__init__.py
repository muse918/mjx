from mjx.const import ActionType, EventType, TileType

_MISSING_CORE_IMPORT_ERROR = None

try:
    from mjx.action import Action
    from mjx.agents import Agent
    from mjx.env import MjxEnv, run
    from mjx.event import Event
    from mjx.hand import Hand
    from mjx.observation import Observation
    from mjx.open import Open
    from mjx.state import State
    from mjx.tile import Tile
except ModuleNotFoundError as exc:
    if exc.name != "_mjx":
        raise
    _MISSING_CORE_IMPORT_ERROR = exc


__all__ = [
    "Action",
    "Event",
    "Observation",
    "State",
    "MjxEnv",
    "Agent",
    "Open",
    "Hand",
    "Tile",
    "run",
    "ActionType",
    "EventType",
    "TileType",
]

_CORE_EXPORTS = {"Action", "Event", "Observation", "State", "MjxEnv", "Agent", "Open", "Hand", "Tile", "run"}


def __getattr__(name):
    if name in _CORE_EXPORTS and _MISSING_CORE_IMPORT_ERROR is not None:
        raise ModuleNotFoundError(
            "mjx core extension '_mjx' is not built. Build/install mjx with CMake (MJX_BUILD_PYTHON=ON)."
        ) from _MISSING_CORE_IMPORT_ERROR
    raise AttributeError(f"module {__name__!r} has no attribute {name!r}")
