<?php
namespace Nereare\Adventure;

class Item {

  private string $name;
  private string $ref;
  private string $type;
  private string $desc;
  private bool $magical;
  private int $weight;
  private float $value;

  public function __construct(
    string $name,
    string $type,
    string $desc,
    bool $magical,
    int $weight,
    float $value,
    string $ref = ""
  ) {
    // Fill item parameters
    $this->name = $name;
    $this->type = $type;
    $this->desc = $desc;
    $this->magical = $magical;
    $this->weight = $weight;
    $this->value = $value;
    $this->ref = $ref;
  }

  /**
   * Retrieves the item's name.
   *
   * @return string The item's name.
   */
  public function get_name(): string {
    return $this->name;
  }

  /**
   * Retrieves the item's type.
   *
   * @return string The item's type.
   */
  public function get_type(): string {
    return $this->type;
  }

  /**
   * Retrieves the item's description.
   *
   * @return string       The item's description, it should be parsed to process markdown notation.
   */
  public function get_desc(): string {
    return $this->desc;
  }

  /**
   * Retrieves the item's magical.
   *
   * @return bool The item's magical.
   */
  public function is_magical(): bool {
    return $this->magical;
  }

  /**
   * Retrieves the item's weight.
   *
   * @return int The item's weight.
   */
  public function get_weight(): int {
    return $this->weight;
  }

  /**
   * Retrieves the item's value.
   *
   * @return float The item's value.
   */
  public function get_value(): float {
    return $this->value;
  }

  /**
   * Retrieves the item's reference.
   *
   * @return string The item's reference.
   */
  public function get_ref(): string {
    return $this->ref;
  }

}
