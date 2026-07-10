# Birb-Bunkers

A multiplayer 2D top-down game built in **Godot 4**, blending base-building, resource gathering, tower defense, and direct combat. Players explore a shared map, grow a nest from a single egg, and choose how to compete — turtle up and defend, raid other players directly, or raise an army of AI-controlled chicks to attack for them.

---

## Concept

Players spawn in separate corners of the map with nothing but one egg. From there:

- **Explore** the map to gather scattered resources
- **Build** a nest from scratch, upgrading weapons, tools, and armor over time
- **Lay eggs** to hatch either combat-capable chicks or AI "attacker" chicks that path toward an enemy base
- **Defend** your nest with towers and traps against incoming chicks and player raids
- **Fight** other players directly with weapons and armor found or crafted along the way

This creates two viable playstyles — turtling and farming, or aggressive raiding — with the tower-defense layer acting as the natural counter to the chick-attack system.

There's also a shared **starter lobby**, similar to Roblox, where players can move around and interact before matches begin.

## Planned Game Modes

- 1v1, 1v1v1, 1v1v1v1
- 2v2
- 4v4

*(Lobby and matchmaking are intentionally deferred to a later development phase.)*

## Core Systems

| System | Description |
|---|---|
| **Player** | Movable character, WASD/arrow key movement |
| **Base Building** | Explore to collect resources; build and expand a nest; automate resource collection |
| **Eggs & Chicks** | Spend resources to hatch chicks — some for direct player-adjacent combat, others as AI units that auto-attack enemy bases |
| **Tower Defense** | Place towers/traps to defend your nest against chick waves and player raids |
| **Combat** | Ranged weapons, craftable/found armor |
| **Death & Respawn** | On death, players respawn into any remaining eggs left in their nest |

## Open Design Questions

- Do chicks pathfind around obstacles/towers, or move in a simpler straight-line path?
- Are chicks a disposable resource or a meaningful investment (cost/time to hatch)?
- Can defensive towers be repurposed for offense, or are they strictly defensive?

## Development Roadmap

Building incrementally, single-player first, networking last:

1. ✅ Player movement (CharacterBody2D + basic 4-directional movement)
2. ⬜ Resource pickups (walk over an item, it's collected, a counter updates)
3. ⬜ Placeable structures (first pass at a tower/nest wall)
4. ⬜ Simple AI-controlled unit that walks a path (first pass at a "chick")
5. ⬜ Combat & health system
6. ⬜ Multiplayer networking (authoritative server, state replication)
7. ⬜ Lobby & matchmaking

## Tech Stack

- **Engine:** Godot 4
- **Language:** GDScript

## Status

Early development. Currently working through Godot editor fundamentals and core mechanics in single-player before introducing networking or matchmaking.

---

*This README will evolve as the design solidifies — treat it as a living doc, not a locked spec.*
