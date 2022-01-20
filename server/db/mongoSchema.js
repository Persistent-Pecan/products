import mongoose from 'mongoose';

const { Schema } = mongoose;

const productsSchema = new Schema({
  product_id: { type: Number, required: true, index: true },
  name: { type: String, required: true },
  slogan: { type: String },
  description: { type: String },
  category: { type: String, required: true },
  default_price: {
    type: Number,
    required() {
      return this.default_price > 0;
    },
  },
  features: [
    {
      feature_id: {
        type: Number,
        required: true,
      },
      feature: { type: String },
      value: { type: String },
    },
  ],
  related_id: [
    {
      id: { type: Number },
    },
  ],

});

const stylesSchema = new Schema({
  style_id: { type: Number, required: true, index: true },
  product_id: { type: Number, required: true },
  name: { type: String, required: true },
  original_price: {
    type: Number,
    required() {
      return this.original_price > 0;
    },
  },
  sale_price: {
    type: Number,
    required() {
      return this.original_price < this.sale_price;
    },
  },
  default: { type: Boolean, required: true },
  photos: [
    {
      id: { type: Number, unique: true },
      thumbnail_url: { type: String },
      url: { type: String },
    },
  ],
  sku: {
    id: { type: Number, unique: true },
    quantity: { type: Number, require() { return this.quantity >= 0; } },
    size: { type: String },
  },

});

const products = mongoose.model('products', productsSchema);

const styles = mongoose.model('styles', stylesSchema);
