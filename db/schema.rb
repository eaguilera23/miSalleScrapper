# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170711202711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "anunciantes", force: :cascade do |t|
    t.string "nombre"
    t.string "telefono"
    t.string "email"
    t.string "empresa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "anuncios", force: :cascade do |t|
    t.string "ruta_imagen"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "anunciante_id"
    t.index ["anunciante_id"], name: "index_anuncios_on_anunciante_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.datetime "fecha_inicio"
    t.integer "vistas_completadas"
    t.integer "vistas_contratadas"
    t.datetime "fecha_termino"
    t.string "destino_click"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "anunciante_id"
    t.bigint "anuncio_id"
    t.index ["anunciante_id"], name: "index_campaigns_on_anunciante_id"
    t.index ["anuncio_id"], name: "index_campaigns_on_anuncio_id"
  end

  create_table "clicks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "campaign_id"
    t.index ["campaign_id"], name: "index_clicks_on_campaign_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.integer "matricula"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
