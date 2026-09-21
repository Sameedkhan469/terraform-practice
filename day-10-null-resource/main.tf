# --------------------------------------------------
# NULL RESOURCE
# --------------------------------------------------

resource "null_resource" "example" {

  # ------------------------------------------------
  # LOCAL-EXEC PROVISIONER
  # ------------------------------------------------
  #
  # null_resource does not create an AWS resource.
  #
  # It simply allows us to run a command.
  #

  provisioner "local-exec" {

    command = "echo Hello ${var.name}"
  }
}