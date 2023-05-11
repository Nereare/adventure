<?php
require "../vendor/autoload.php";
require "../php/meta.php";
session_start();
?>
<!DOCTYPE html>
<html lang="pt_BR">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link rel="apple-touch-icon" sizes="180x180" href="../assets/favicon/apple-touch-icon.png">
  <link rel="icon" type="image/png" sizes="32x32" href="../assets/favicon/favicon-32x32.png">
  <link rel="icon" type="image/png" sizes="16x16" href="../assets/favicon/favicon-16x16.png">
  <link rel="manifest" href="../assets/favicon/site.webmanifest">
  <link rel="mask-icon" href="../assets/favicon/safari-pinned-tab.svg" color="#4e342e">
  <link rel="shortcut icon" href="../assets/favicon/favicon.ico">
  <meta name="msapplication-TileColor" content="#4e342e">
  <meta name="msapplication-TileImage" content="../assets/favicon/mstile-144x144.png">
  <meta name="msapplication-config" content="../assets/favicon/browserconfig.xml">
  <meta name="theme-color" content="#ffffff">

  <title><?php echo constant("APP_NAME"); ?></title>

  <link rel="stylesheet" href="../node_modules/@mdi/font/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="../node_modules/typeface-montserrat/index.css">
  <link rel="stylesheet" href="../node_modules/typeface-roboto-mono/index.css">
  <link rel="stylesheet" href="../css/style.css">

  <script type="text/javascript" src="../node_modules/jquery/dist/jquery.min.js" charset="utf-8"></script>
  <script type="text/javascript" src="../js/common.js" charset="utf-8"></script>
  <script type="text/javascript" src="../js/install.js" charset="utf-8"></script>
</head>

<body>

  <header class="hero is-primary">
    <div class="hero-body has-text-centered">
      <p class="title">
        <?php echo constant("APP_NAME"); ?>
      </p>
      <p class="subtitle">
        Installer
      </p>
    </div>
  </header>

  <main class="section">
    <form class="container" id="install-form">
      <div class="box">
        <h2 class="title is-4">
          <span class="icon-text">
            <span class="icon">
              <i class="mdi mdi-application mdi-36px"></i>
            </span>
            <span>Instalação</span>
          </span>
        </h2>

        <div class="field">
          <div class="control has-icons-left">
            <input type="text" class="input is-large" id="instance-name" placeholder="Nome da Instância" required autofocus>
            <span class="icon is-large is-left">
              <i class="mdi mdi-head mdi-48px"></i>
            </span>
          </div>
        </div>

        <div class="field">
          <div class="control has-text-centered">
            <input type="checkbox" class="switch is-success is-medium" id="instance-production" checked>
            <label for="instance-production">Produção</label>
          </div>
        </div>

        <div class="field">
          <div class="control has-icons-left">
            <input type="text" class="input" id="instance-uri" placeholder="URI Base" required>
            <span class="icon is-left">
              <i class="mdi mdi-link mdi-24px"></i>
            </span>
          </div>
        </div>

        <div class="field">
          <div class="control has-icons-left is-expanded">
            <div class="select is-fullwidth">
              <select id="instance-protocol" required>
                <option value="" selected disabled>URI Protocol</option>
                <option value="https">Seguro</option>
                <option value="http">Inseguro</option>
              </select>
            </div>
            <span class="icon is-left">
              <i class="mdi mdi-protocol mdi-24px"></i>
            </span>
          </div>
        </div>

        <div>
          <div class="divider">&bull;&nbsp;&bull;&nbsp;&bull;</div>
        </div>

        <h2 class="title is-4">
          <span class="icon-text">
            <span class="icon">
              <i class="mdi mdi-database mdi-36px"></i>
            </span>
            <span>Banco de Dados</span>
          </span>
        </h2>

        <div class="field">
          <div class="control has-icons-left">
            <input type="text" class="input" id="db-name" placeholder="Nome" required>
            <span class="icon is-left">
              <i class="mdi mdi-database mdi-24px"></i>
            </span>
          </div>
        </div>

        <div class="field">
          <div class="control has-icons-left">
            <input type="text" class="input" id="db-username" placeholder="Usuário" required>
            <span class="icon is-left">
              <i class="mdi mdi-database-cog mdi-24px"></i>
            </span>
          </div>
        </div>

        <div class="field">
          <div class="control has-icons-left">
            <input type="password" class="input" id="db-password" placeholder="Senha" required>
            <span class="icon is-left">
              <i class="mdi mdi-database-lock mdi-24px"></i>
            </span>
          </div>
        </div>

        <div>
          <div class="divider">&bull;&nbsp;&bull;&nbsp;&bull;</div>
        </div>

        <h2 class="title is-4">
          <span class="icon-text">
            <span class="icon">
              <i class="mdi mdi-account-circle mdi-36px"></i>
            </span>
            <span>Admin</span>
          </span>
        </h2>

        <div class="field">
          <div class="control has-icons-left">
            <input type="text" class="input" id="admin-username" placeholder="Usuário" required>
            <span class="icon is-left">
              <i class="mdi mdi-account mdi-24px"></i>
            </span>
          </div>
        </div>

        <div class="field">
          <div class="control has-icons-left">
            <input type="password" class="input" id="admin-password" placeholder="Senha" required>
            <span class="icon is-left">
              <i class="mdi mdi-lock mdi-24px"></i>
            </span>
          </div>
        </div>

        <div class="field">
          <div class="control has-icons-left">
            <input type="email" class="input" id="admin-email" placeholder="Email" required>
            <span class="icon is-left">
              <i class="mdi mdi-email mdi-24px"></i>
            </span>
          </div>
        </div>
      </div>

      <div class="box">
        <div class="field">
          <div class="control is-expanded">
            <button type="submit" class="button is-success is-fullwidth">
              <span class="icon-text">
                <span class="icon">
                  <i class="mdi mdi-content-save mdi-24px"></i>
                </span>
                <span>Instalar</span>
              </span>
            </button>
          </div>
        </div>
      </div>
    </form>
  </main>

  <footer class="footer pt-3 pb-4">
    <div class="content has-text-centered">
      <p class="mb-2">
        <strong><?php echo constant("APP_NAME"); ?></strong>
      </p>
      <p class="is-size-7">
        <a href="<?php echo constant("APP_REPO"); ?>">
          <?php echo constant("APP_NAME"); ?>
        </a>
        &copy;
        <?php echo constant("APP_YEAR"); ?>
        <?php echo constant("APP_AUTHOR"); ?>
        &bull;
        Distribuido sob a
        <a href="<?php echo constant("APP_LICENSE_URI"); ?>">
          <?php echo constant("APP_LICENSE_NAME"); ?>
        </a>
      </p>
    </div>
  </footer>

  <div class="notification is-hidden" id="notification">
    <button class="delete"></button>
    <p>Foo</p>
  </div>

</body>

</html>
