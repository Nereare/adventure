<?php require_once "header.php"; ?>

<main class="section">
  <div class="container">
    <div class="box">
      <?php
      /*
       * DB Storage:
       * Serialize the object, then base64 encode it.
       * $bar = base64_encode(serialize($loot));
       *
       * Store the processed object under a LARGEBLOB column
       * var_dump($bar);
       *
       * To retrieve the object, reverse the encoding:
       * FIRST base64 DEcode, THEN unserialize it.
       * var_dump(unserialize(base64_decode($bar)));
       */

      $loot = new \Nereare\Adventure\Loot([
        new \Nereare\Adventure\Item("sword of dandelions", "weapon", "A sword made from the condensed seed of thousands of dandelions", false, 10, 12.0),
        new \Nereare\Adventure\Item("mace of silver", "weapon", "A mace made from solid sterling silver", false, 15, 1280.0, "DMGV p.18"),
        new \Nereare\Adventure\Item("bottle", "misc", "A glass bottle", false, 0, 0.1, "DMGV p.21"),
        new \Nereare\Adventure\Item("ring of tentacles", "wondrous item (rare)", "Once per day, you can use your action to say the ring's command word and summon 2d8 touchy tentacles, each of which is compelled to fuck you mindless.", true, 0, 12000.0)
      ], 8, 8, 3, 1, 8);
      $foo = new \Nereare\Adventure\Challenge(
        15,
        "Arcana",
        "",
        "Success",
        "Fail",
        false,
        $loot,
        new \Nereare\Adventure\Loot(null, 0, 128, 201),
        20,
        "Critical success",
        new \Nereare\Adventure\Loot(null, 80, 248, 790)
      );
      var_dump($foo);
      ?>
    </div>
  </div>
</main>

<?php require_once "footer.php"; ?>
