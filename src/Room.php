<?php
namespace Nereare\Adventure;

class Room {

  private string                            $name;
  private string                            $desc;
  private string                            $noises;
  private bool                              $dark;
  private \Nereare\Adventure\Challenge|null $perception;
  private \Nereare\Adventure\Challenge|null $investigation;
  private \Nereare\Adventure\Loot|null      $contents;
  private array                             $exits;

  public function __construct(
    string $name,
    string $desc,
    string $noises,
    bool $dark = false,
    \Nereare\Adventure\Challenge|null $perception = null,
    \Nereare\Adventure\Challenge|null $investigation = null,
    \Nereare\Adventure\Loot|null $contents = null
  ) {
    $this->name           = $name;
    $this->desc           = $desc;
    $this->noises         = $noises;
    $this->dark           = $dark;
    $this->perception     = $perception;
    $this->investigation  = $investigation;
    $this->contents       = $contents;
  }
}
