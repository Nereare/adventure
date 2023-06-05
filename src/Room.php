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

    $this->exits          = [];
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

  /**
   * Retrieve the room's exits.
   *
   * @return array   The room's exits, if any, as an array of arrays, each composed of the room's IDs (item 0) and the exit's text for this room (item 1).
   */
  public function get_exits(): array {
    return $this->exits;
  }

  /**
   * Add a new room as an exit of the current one.
   *
   * @param string $room_id    The UUID for the exit room.
   * @param string $room_txt   The text to be displayed.
   * @return void
   */
  public function add_exit(string $room_id, string $room_txt) {
    $this->exits[] = [$room_id, $room_txt];
  }

  /**
   * Remove an exit from the room's exits by its internal index.
   *
   * @param integer $index   The internal integer index of this exit.
   * @return void
   */
  public function remove_exit_by_index(int $index) {
    unset($this->exits[$index]);
  }

  /**
   * Remove an exit from the room's exits by its UUID.
   *
   * @param string $room_id   The UUID of this exit.
   * @return boolean          `true` if the room is an exit and has been removed, `false` otherwise.
   */
  public function remove_exit_by_id(string $room_id): bool {
    $return_index = null;
    foreach ($this->exits as $index => $room) {
      if ($room[0] == $room_id) {
        $return_index = $index;
      }
    }

    if ($return_index === null) {
      return false;
    } else {
      $this->remove_exit_by_index($return_index);
      return true;
    }
  }
}
