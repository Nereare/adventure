<?php
namespace Nereare\Adventure;
use Rhumsaa\Uuid\Uuid;

class Room {

  private string                            $id;
  private string                            $name;
  private string                            $desc;
  private string|null                       $noises;
  private bool                              $dark;
  private \Nereare\Adventure\Challenge|null $perception;
  private \Nereare\Adventure\Challenge|null $investigation;
  private \Nereare\Adventure\Loot|null      $contents;
  private array                             $exits;

  public function __construct(
    string $name,
    string $desc,
    string|null $noises = null,
    bool $dark = false,
    \Nereare\Adventure\Challenge|null $perception = null,
    \Nereare\Adventure\Challenge|null $investigation = null,
    \Nereare\Adventure\Loot|null $contents = null
  ) {
    $uuid = Uuid::uuid4();
    $this->id             = $uuid->toString();

    $this->name           = $name;
    $this->desc           = $desc;
    $this->noises         = $noises;
    $this->dark           = $dark;
    $this->perception     = $perception;
    $this->investigation  = $investigation;
    $this->contents       = $contents;
  }

  /**
   * Retrieve the room's ID.
   *
   * @return string   The room's ID.
   */
  public function get_id(): string {
    return $this->id;
  }

  /**
   * Retrieve the room's name.
   *
   * @return string   The room's name.
   */
  public function get_name(): string {
    return $this->name;
  }

  /**
   * Retrieve the room's description.
   *
   * @return string   The room's description.
   */
  public function get_desc(): string {
    return $this->desc;
  }

  /**
   * Retrieve the room's possible noises.
   *
   * @return string|null   The room's possible noises, or null if none.
   */
  public function get_noises(): string|null {
    return $this->noises;
  }

  /**
   * Retrieve the room's darkness status.
   *
   * @return bool   `true` if the room is dark, `false` otherwise.
   */
  public function is_dark(): bool {
    return $this->dark;
  }

  /**
   * Retrieve the room's perception skill challenge.
   *
   * @return \Nereare\Adventure\Challenge|null   The room's perception skill challenge, or `null` if none.
   */
  public function get_perception(): \Nereare\Adventure\Challenge|null {
    return $this->perception;
  }

  /**
   * Retrieve the room's investigation skill challenge.
   *
   * @return \Nereare\Adventure\Challenge|null   The room's investigation skill challenge, or `null` if none.
   */
  public function get_investigation(): \Nereare\Adventure\Challenge|null {
    return $this->investigation;
  }

  /**
   * Retrieve the room's loot contents.
   *
   * @return \Nereare\Adventure\Loot|null   The room's loot contents, or `null` if none.
   */
  public function get_contents(): \Nereare\Adventure\Loot|null {
    return $this->contents;
  }
}
