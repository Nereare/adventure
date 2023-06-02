<?php
namespace Nereare\Adventure;

class Loot {

  /**
   * An integer value to define the format for retrieving loot items.
   *
   * This defines the return as an array.
   *
   * @var int   0
   */
  const FORMAT_ARRAY = 0;
  /**
   * An integer value to define the format for retrieving loot items.
   *
   * This defines the return as a simple list of the items' names.
   *
   * @var int   1
   */
  const FORMAT_HUMAN_SHORT = 1;
  /**
   * An integer value to define the format for retrieving loot items.
   *
   * This defines the return as a list with names, references, and notes.
   *
   * @var int   2
   */
  const FORMAT_HUMAN_LONG = 2;

  private array      $items;
  private int        $cp;
  private int        $sp;
  private int        $gp;
  private int        $ep;
  private int        $pp;

  /**
   * Initializes a loot content based on fixed components.
   *
   * @param  array|null   $items   A list of `\Nereare\Adventure\Item`s available as part of the loot, or `null` if no items are available.
   * @param  integer      $cp      The amount of copper pieces available.
   * @param  integer      $sp      The amount of silver pieces available.
   * @param  integer      $gp      The amount of gold pieces available.
   * @param  integer      $ep      The amount of electrum pieces available.
   * @param  integer      $pp      The amount of platinum pieces available.
   */
  public function __construct(array|null $items, int $cp = 0, int $sp = 0, int $gp = 0, int $ep = 0, int $pp = 0) {
    // Fill loot contents
    $this->items = ($items == null) ? [] : $items;
    $this->cp = $cp;
    $this->sp = $sp;
    $this->gp = $gp;
    $this->ep = $ep;
    $this->pp = $pp;
  }

  /**
   * Parses the object to string as a list of the loot's contents.
   *
   * @return string   A list of all the objects in the loot, as well as the amount of each coin.
   */
  public function __toString(): string {
    $list = [];
    $items = $this->get_items(self::FORMAT_ARRAY);
    if (count($items) > 0) {
      foreach ($items as $item) {
        $list[] = $item->get_name();
      }
    } else {
      $list[] = "no items";
    }
    $list[] = $this->get_cp() . "cp";
    $list[] = $this->get_sp() . "sp";
    $list[] = $this->get_gp() . "gp";
    $list[] = $this->get_ep() . "ep";
    $list[] = $this->get_pp() . "pp";
    $last = array_pop($list);
    $r = join(", ", $list);
    $r .= ", and " . $last;
    return $r;
  }

  /******************************************/
  /*              ITEM METHODS              */
  /******************************************/

  /**
   * List the items available in the loot.
   *
   * @param int $format     An integer representing the type of format to return the item list in.
   * @return array|string   The list of items in the loot.
   */
  public function get_items(int $format = self::FORMAT_ARRAY): array|string {
    switch ($format) {
      case $this::FORMAT_ARRAY:
        return $this->items;
      case $this::FORMAT_HUMAN_SHORT:
        return $this->short_list($this->items);
      case $this::FORMAT_HUMAN_LONG:
        return $this->long_list($this->items);
      default:
        throw new \Nereare\Adventure\AdventureException("The format must be one of the three predefined ones.");
    }
  }

  /**
   * Turn an array into a human-readable list - without details.
   *
   * @param array $list   The array to transform into a list.
   * @return string       A human-readable list.
   */
  private function short_list(array $list): string {
    $rlist = [];
    $ret = "";
    if (count($list) > 0) {
      foreach ($list as $item) {
        $rlist[] = $item->get_name();
      }
      if (count($rlist) > 2) {
        $last = array_pop($rlist);
        $ret = join(", ", $rlist);
        $ret .= ", and " . $last;
      } else {
        $ret = join(" and ", $rlist);
      }
    }
    return $ret;
  }

  /**
   * Turn an array into a human-readable list - with details.
   *
   * @param array $list   The array to transform into a list.
   * @return string       A human-readable list.
   */
  private function long_list(array $list): string {
    $rlist = [];
    $ret = "";
    if (count($list) > 0) {
      foreach ($list as $item) {
        $foo = $item->get_name();
        if ($item->get_ref() != "") {
          $foo .=  " (" . $item->get_ref() . ")";
        }
        $rlist[] = $foo;
      }
      if (count($rlist) > 2) {
        $last = array_pop($rlist);
        $ret = join(", ", $rlist);
        $ret .= ", and " . $last;
      } else {
        $ret = join(" and ", $rlist);
      }
    }
    return $ret;
  }

  /**
   * Add new item to the loot's item list.
   *
   * @param \Nereare\Adventure\Item $item   The new item to add.
   * @return void
   */
  public function add_item(\Nereare\Adventure\Item $item) {
    $this->items[] = $item;
  }

  /**
   * Remove an existing item from the loot's item list.
   *
   * @param integer $index   The index of the item to delete in the `items` array.
   * @return void
   */
  public function take_item(int $index) {
    unset($this->items[$index]);
  }

  /******************************************/
  /*              COIN METHODS              */
  /******************************************/

  /**
   * Calculate the total amount of coins in the loot, in gold pieces.
   *
   * @return float   The gold piece total of coins in the loot.
   */
  public function total_coins(): float {
    $total = (float) $this->gp;
    $total += (float) $this->pp * 10;
    $total += (float) $this->ep * 5;
    $total += (float) $this->sp / 10;
    $total += (float) $this->cp / 100;
    return $total;
  }

  /**
   * Retrieves the total number of copper pieces available in the loot.
   *
   * @return int   An integer representing the total number of copper pieces available.
   */
  public function get_cp(): int {
    return $this->cp;
  }
  /**
   * Set the total number of copper pieces available the the new value.
   *
   * @param int $new   The new amount of copper pieces.
   */
  public function set_cp(int $new) {
    $this->cp = $new;
  }
  /**
   * Adds to the current amount of copper pieces available.
   *
   * @param int $plus   The amount of copper pieces to add.
   */
  public function add_cp(int $plus) {
    $this->cp += $plus;
  }
  /**
   * Removes from the current amount of copper pieces available.
   *
   * @param int $minus          The amount of copper pieces to substract.
   * @throws AdventureException   If the amount of copper pieces to substract is higher than the current available.
   */
  public function take_cp(int $minus) {
    if ($minus <= $this->cp) {
      $this->cp -= $minus;
    } else {
      throw new \Nereare\Adventure\AdventureException("The subsctraction of coins must be equal to or less the amount already present.");
    }
  }
  /**
   * Retrieves the total number of silver pieces available in the loot.
   *
   * @return int   An integer representing the total number of silver pieces available.
   */
  public function get_sp(): int {
    return $this->sp;
  }
  /**
   * Set the total number of silver pieces available the the new value.
   *
   * @param int $new   The new amount of silver pieces.
   */
  public function set_sp(int $new) {
    $this->sp = $new;
  }
  /**
   * Adds to the current amount of silver pieces available.
   *
   * @param int $plus   The amount of silver pieces to add.
   */
  public function add_sp(int $plus) {
    $this->sp += $plus;
  }
  /**
   * Removes from the current amount of silver pieces available.
   *
   * @param int $minus          The amount of silver pieces to substract.
   * @throws AdventureException   If the amount of silver pieces to substract is higher than the current available.
   */
  public function take_sp(int $minus) {
    if ($minus <= $this->sp) {
      $this->sp -= $minus;
    } else {
      throw new \Nereare\Adventure\AdventureException("The subsctraction of coins must be equal to or less the amount already present.");
    }
  }
  /**
   * Retrieves the total number of gold pieces available in the loot.
   *
   * @return int   An integer representing the total number of gold pieces available.
   */
  public function get_gp(): int {
    return $this->gp;
  }
  /**
   * Set the total number of gold pieces available the the new value.
   *
   * @param int $new   The new amount of gold pieces.
   */
  public function set_gp(int $new) {
    $this->gp = $new;
  }
  /**
   * Adds to the current amount of gold pieces available.
   *
   * @param int $plus   The amount of gold pieces to add.
   */
  public function add_gp(int $plus) {
    $this->gp += $plus;
  }
  /**
   * Removes from the current amount of gold pieces available.
   *
   * @param int $minus          The amount of gold pieces to substract.
   * @throws AdventureException   If the amount of gold pieces to substract is higher than the current available.
   */
  public function take_gp(int $minus) {
    if ($minus <= $this->gp) {
      $this->gp -= $minus;
    } else {
      throw new \Nereare\Adventure\AdventureException("The subsctraction of coins must be equal to or less the amount already present.");
    }
  }
  /**
   * Retrieves the total number of electrum pieces available in the loot.
   *
   * @return int   An integer representing the total number of electrum pieces available.
   */
  public function get_ep(): int {
    return $this->ep;
  }
  /**
   * Set the total number of electrum pieces available the the new value.
   *
   * @param int $new   The new amount of electrum pieces.
   */
  public function set_ep(int $new) {
    $this->ep = $new;
  }
  /**
   * Adds to the current amount of electrum pieces available.
   *
   * @param int $plus   The amount of electrum pieces to add.
   */
  public function add_ep(int $plus) {
    $this->ep += $plus;
  }
  /**
   * Removes from the current amount of electrum pieces available.
   *
   * @param int $minus          The amount of electrum pieces to substract.
   * @throws AdventureException   If the amount of electrum pieces to substract is higher than the current available.
   */
  public function take_ep(int $minus) {
    if ($minus <= $this->ep) {
      $this->ep -= $minus;
    } else {
      throw new \Nereare\Adventure\AdventureException("The subsctraction of coins must be equal to or less the amount already present.");
    }
  }
  /**
   * Retrieves the total number of platinum pieces available in the loot.
   *
   * @return int   An integer representing the total number of platinum pieces available.
   */
  public function get_pp(): int {
    return $this->pp;
  }
  /**
   * Set the total number of platinum pieces available the the new value.
   *
   * @param int $new   The new amount of platinum pieces.
   */
  public function set_pp(int $new) {
    $this->pp = $new;
  }
  /**
   * Adds to the current amount of platinum pieces available.
   *
   * @param int $plus   The amount of platinum pieces to add.
   */
  public function add_pp(int $plus) {
    $this->pp += $plus;
  }
  /**
   * Removes from the current amount of platinum pieces available.
   *
   * @param int $minus          The amount of platinum pieces to substract.
   * @throws AdventureException   If the amount of platinum pieces to substract is higher than the current available.
   */
  public function take_pp(int $minus) {
    if ($minus <= $this->pp) {
      $this->pp -= $minus;
    } else {
      throw new \Nereare\Adventure\AdventureException("The subsctraction of coins must be equal to or less the amount already present.");
    }
  }

  /******************************************/
  /*             MERGING METHOD             */
  /******************************************/

  /**
   * Merges two loots together.
   *
   * @param \Nereare\Adventure\Loot $loot   The loot to be added.
   * @return void
   */
  public function merge(\Nereare\Adventure\Loot $loot) {
    if (count($loot->get_items()) > 0) {
      foreach ($loot->get_items() as $item) {
        $this->add_item($item);
      }
      $this->add_cp($item->get_cp());
      $this->add_sp($item->get_sp());
      $this->add_gp($item->get_gp());
      $this->add_ep($item->get_ep());
      $this->add_pp($item->get_pp());
    }
  }
}
