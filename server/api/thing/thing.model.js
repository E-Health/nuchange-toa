'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var ThingSchema = new Schema({
  name: String,
  identifier: String,
  avtar: String,
  dob: String,
  datet: String,
  mrp: String,
  nurse: String,
  story: String,
  assessment: String,
  followup: String,
  evaluation: String,
  active: Boolean
});

module.exports = mongoose.model('Thing', ThingSchema);