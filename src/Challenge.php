<?php
namespace Nereare\Adventure;

class Challenge {

  private int                     $dc;
  private int                     $dc_p5;
  private int                     $dc_p90;
  private string                  $skill;
  private string                  $desc_base;
  private string                  $desc_postsuccess;
  private string                  $desc_postfailure;
  private string                  $success_msg;
  private \Nereare\Adventure\Loot $success_loot;
  private string                  $fail_msg;
  private \Nereare\Adventure\Loot $fail_loot;
  private string                  $success_crit_msg;
  private \Nereare\Adventure\Loot $success_crit_loot;
  private string                  $fail_crit_msg;
  private \Nereare\Adventure\Loot $fail_crit_loot;
  private bool                    $retry;
  private bool                    $won_crit;
  private bool                    $won;
  private bool                    $failed;
  private bool                    $failed_crit;

  public function __construct(
    int $dc,
    string $skill,
    string $desc_base,
    string $desc_postsuccess,
    string $desc_postfailure,
    string $success_msg,
    string $fail_msg,
    bool $retry = false,
    \Nereare\Adventure\Loot $success_loot = null,
    \Nereare\Adventure\Loot $fail_loot = null,
    int $dc_p90 = null,
    string|null $success_crit_msg = null,
    \Nereare\Adventure\Loot|null $success_crit_loot = null,
    int $dc_p5 = null,
    string|null $fail_crit_msg = null,
    \Nereare\Adventure\Loot|null $fail_crit_loot = null
  ) {
    $this->dc = $dc;
    $this->skill = $skill;
    $this->desc_base = $desc_base;
    $this->desc_postsuccess = $desc_postsuccess;
    $this->desc_postfailure = $desc_postfailure;
    $this->success_msg = $success_msg;
    $this->fail_msg = $fail_msg;
    $this->retry = $retry;
    $this->won_crit = false;
    $this->won = false;
    $this->failed = false;
    $this->failed_crit = false;
    // Set success and failure loots, if set
    if (isset($success_loot)) {
      $this->success_loot = $success_loot;
    } else {
      $this->success_loot = new \Nereare\Adventure\Loot([]);
    }
    if (isset($fail_loot)) {
      $this->fail_loot = $fail_loot;
    } else {
      $this->fail_loot = new \Nereare\Adventure\Loot([]);
    }
    // If a critical success DC is set, make checks
    if (isset($dc_p90)) {
      // There must be, at least, a message or a loot
      if ((isset($success_crit_msg) && $success_crit_msg != "") || isset($success_crit_loot)) {
        // Initialize parameters, if there is
        $this->dc_p90 = $dc_p90;
        if (isset($success_crit_msg)) {
          $this->success_crit_msg = $success_crit_msg;
        }
        if (isset($success_crit_loot)) {
          $this->success_crit_loot = $success_crit_loot;
        } else {
          $this->success_crit_loot = new \Nereare\Adventure\Loot([]);
        }
      } else {
        // Throw an error, otherwise
        throw new \Nereare\Adventure\AdventureException("When creating a critical success, inform, at least, a message or a loot.");
      }
    }
    // If a critical failure DC is set, make checks
    if (isset($dc_p5)) {
      // There must be, at least, a message or a loot
      if ((isset($fail_crit_msg) && $fail_crit_msg != "") || isset($fail_crit_loot)) {
        // Initialize parameters, if there is
        $this->dc_p5 = $dc_p5;
        if (isset($fail_crit_msg)) {
          $this->fail_crit_msg = $fail_crit_msg;
        }
        if (isset($fail_crit_loot)) {
          $this->fail_crit_loot = $fail_crit_loot;
        } else {
          $this->fail_crit_loot = new \Nereare\Adventure\Loot([]);
        }
      } else {
        // Throw an error, otherwise
        throw new \Nereare\Adventure\AdventureException("When creating a critical failure, inform, at least, a message or a loot.");
      }
    }
  }

  /**
   * Retrieve the challenge's skill.
   *
   * @return string   The skill.
   */
  public function get_skill(): string {
    return $this->skill;
  }

  /**
   * Retrieve the challenge's description.
   *
   * @return string   The description, it should be parsed to process markdown notation.
   */
  public function get_desc(): string {
    if (!$this->won && !$this->failed) {
      return $this->desc_base;
    } elseif ($this->won) {
      return $this->desc_postsuccess;
    } else {
      return $this->desc_postfailure;
    }
  }

  /**
   * The current text-state of the Challenge. Same as `get_desc`.
   *
   * @return string   The description, it should be parsed to process markdown notation.
   */
  public function __toString(): string {
    return $this->get_desc();
  }

  /**
   * Whether or not the challenge is open to try it.
   *
   * @return boolean   `true` if one can roll for this challenge, `false` otherwise.
   */
  public function is_open(): bool {
    if (($this->won_crit || $this->won || $this->failed || $this->failed_crit) && !$this->retry) {
      return false;
    } else {
      return true;
    }
  }

  /**
   * Try and roll for the challenge.
   *
   * After this method is called for the first time, it can only be recalled it the challenge has the `retry` parameter set to `true`.
   *
   * @param integer $roll   The result of the roll.
   * @return void
   */
  public function roll(int $roll) {
    if ($this->is_open()) {
      if ($roll >= $this->dc) {
        $this->won = true;
        if ($roll >= $this->dc_p90) {
          $this->won_crit = true;
        }
      } else {
        $this->failed = true;
        if ($roll < $this->dc_p5) {
          $this->failed_crit = true;
        }
      }
    }
  }

  /**
   * Retrieves the message to the result of the challenge.
   *
   * @return string|false   The message string, if the challenge was tried, or `false` otherwise.
   */
  public function get_reply(): string|false {
    if ($this->won_crit) {
      return $this->success_msg . PHP_EOL . PHP_EOL . $this->success_crit_msg;
    } elseif ($this->won) {
      return $this->success_msg;
    } elseif ($this->failed) {
      return $this->fail_msg;
    } elseif ($this->failed_crit) {
      return $this->fail_msg . PHP_EOL . PHP_EOL . $this->fail_crit_msg;
    } else {
      return false;
    }
  }

  public function get_loot(): \Nereare\Adventure\Loot|false {
    if ($this->won_crit) {
      return isset($this->success_crit_loot) ? $this->success_crit_loot : false;
    } elseif ($this->won) {
      return isset($this->success_loot) ? $this->success_loot : false;
    } elseif ($this->failed) {
      return isset($this->fail_loot) ? $this->fail_loot : false;
    } elseif ($this->failed_crit) {
      return isset($this->fail_crit_loot) ? $this->fail_crit_loot : false;
    } else {
      return false;
    }
  }
}
