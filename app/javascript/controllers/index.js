// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import OrderDetailController from "./order_detail_controller"
application.register("order-detail", OrderDetailController)

import OrderFormController from "./order_form_controller"
application.register("order-form", OrderFormController)

import OrderStatusController from "./order_status_controller"
application.register("order-status", OrderStatusController)
