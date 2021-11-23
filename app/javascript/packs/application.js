// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

import 'bootstrap'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

window.togglePaymentOptions = function () {
  var paymentOptions = document.getElementById("payment_method_payment_type");
  var creditCardDiv = document.getElementById("credit_card_fields");
  if (paymentOptions.options[paymentOptions.selectedIndex].text == "Cartão de Crédito") {
    creditCardDiv.style.display = 'block';
  } else {
    creditCardDiv.style.display = 'none';
  }
}
