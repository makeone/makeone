# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "am_technologies", :force => true do |t|
    t.string "name",        :limit => 45
    t.string "acronym",     :limit => 45
    t.string "description"
    t.string "url"
  end

  create_table "assemblages", :id => false, :force => true do |t|
    t.integer "id",        :null => false
    t.integer "system_id", :null => false
  end

  add_index "assemblages", ["system_id"], :name => "fk_composite_structures_system1"

  create_table "cad_cam_software", :force => true do |t|
    t.string "name",        :limit => 45
    t.string "description"
    t.string "version",     :limit => 10
  end

  create_table "cad_cam_software_companies", :id => false, :force => true do |t|
    t.integer "company_id",          :null => false
    t.integer "cad_cam_software_id", :null => false
  end

  add_index "cad_cam_software_companies", ["cad_cam_software_id"], :name => "fk_companies_has_cad_cam_software_cad_cam_software1"
  add_index "cad_cam_software_companies", ["company_id"], :name => "fk_companies_has_cad_cam_software_companies1"

  create_table "calibration_techniques", :force => true do |t|
    t.string "name",                :limit => 45
    t.string "description"
    t.text   "process_description"
  end

  create_table "calibrations", :force => true do |t|
    t.integer "calibration_techniques_idcalibration_techniques", :null => false
  end

  add_index "calibrations", ["calibration_techniques_idcalibration_techniques"], :name => "fk_calibrations_calibration_techniques1"

  create_table "chemical_properties", :force => true do |t|
    t.string "resistance_to_chemicals", :limit => 45
    t.string "resistance_to_petroleum", :limit => 45
    t.string "resistance_to_acids",     :limit => 45
    t.string "biodegration",            :limit => 45
    t.string "mineralizatino",          :limit => 45
    t.string "water_permeability",      :limit => 45
    t.string "water_absorption",        :limit => 45
    t.string "corrosion_rate",          :limit => 45
    t.string "flammability",            :limit => 45
  end

  create_table "companies", :force => true do |t|
    t.string "name",        :limit => 45
    t.string "acronym",     :limit => 8
    t.string "description"
    t.string "homepage"
    t.string "country",     :limit => 45
  end

  create_table "composite_structures", :id => false, :force => true do |t|
    t.integer "id",        :null => false
    t.integer "system_id", :null => false
  end

  add_index "composite_structures", ["system_id"], :name => "fk_composite_structures_system1"

  create_table "digital_test_methods", :force => true do |t|
    t.string "name",                :limit => 45
    t.string "description"
    t.string "reference_url"
    t.text   "process_description"
  end

  create_table "digital_test_methods_models", :id => false, :force => true do |t|
    t.integer "model_id",               :null => false
    t.integer "digital_test_method_id", :null => false
  end

  add_index "digital_test_methods_models", ["digital_test_method_id"], :name => "fk_models_has_digital_test_methods_digital_test_methods1"
  add_index "digital_test_methods_models", ["model_id"], :name => "fk_models_has_digital_test_methods_models1"

  create_table "electrical_properties", :force => true do |t|
    t.string "conductivity",         :limit => 45
    t.string "resistivity",          :limit => 45
    t.string "volume_resistivity",   :limit => 45
    t.string "dissipation_factor",   :limit => 45
    t.string "dielectric_strength",  :limit => 45
    t.string "dielectric_breakdown", :limit => 45
    t.string "arc_resistance",       :limit => 45
  end

  create_table "electronics", :id => false, :force => true do |t|
    t.integer "id",        :null => false
    t.integer "system_id", :null => false
  end

  add_index "electronics", ["system_id"], :name => "fk_electronics_system1"

  create_table "footnotes", :force => true do |t|
    t.string  "table_name",  :limit => 45, :null => false
    t.string  "column_name", :limit => 45
    t.integer "record_id"
    t.text    "footnote",                  :null => false
  end

  create_table "formats", :force => true do |t|
    t.string  "name",        :limit => 45
    t.string  "description"
    t.boolean "is_binary"
    t.string  "version",     :limit => 45
    t.string  "spec_url"
    t.string  "extension",   :limit => 5
  end

  create_table "intended_uses", :force => true do |t|
    t.integer "property_id", :null => false
  end

  create_table "licenses", :force => true do |t|
  end

  create_table "machines", :force => true do |t|
    t.integer "am_technology_id",                     :null => false
    t.integer "company_id",                           :null => false
    t.string  "model_name",             :limit => 45
    t.string  "description"
    t.string  "build_technique"
    t.integer "build_height"
    t.integer "build_width"
    t.integer "build_depth"
    t.string  "build_volume",           :limit => 45
    t.integer "height"
    t.integer "width"
    t.integer "depth"
    t.string  "volume",                 :limit => 45
    t.integer "weight"
    t.string  "energy_source",          :limit => 45
    t.string  "cost_x1000",             :limit => 10
    t.string  "maintenance_cost_x1000", :limit => 10
  end

  add_index "machines", ["am_technology_id"], :name => "fk_machines_am_technologies1"
  add_index "machines", ["company_id"], :name => "fk_machines_companies1"

  create_table "machines_calibrations", :id => false, :force => true do |t|
    t.integer "calibration_id", :null => false
    t.integer "machines_id",    :null => false
  end

  add_index "machines_calibrations", ["calibration_id"], :name => "fk_machines_has_calibrations_calibrations1"
  add_index "machines_calibrations", ["machines_id"], :name => "fk_machines_calibrations_machines1"

  create_table "machines_materials", :id => false, :force => true do |t|
    t.integer "materials_id", :null => false
    t.integer "machines_id",  :null => false
  end

  add_index "machines_materials", ["machines_id"], :name => "fk_materials_has_machines_machines1"
  add_index "machines_materials", ["materials_id"], :name => "fk_materials_has_machines_materials1"

  create_table "machines_models", :id => false, :force => true do |t|
    t.integer "machine_id", :null => false
    t.integer "model_id",   :null => false
  end

  add_index "machines_models", ["machine_id"], :name => "fk_machines_has_models_machines1"
  add_index "machines_models", ["model_id"], :name => "fk_machines_has_models_models1"

  create_table "machines_parts", :id => false, :force => true do |t|
    t.integer "part_id",    :null => false
    t.integer "machine_id", :null => false
  end

  add_index "machines_parts", ["machine_id"], :name => "fk_parts_has_machines_machines1"
  add_index "machines_parts", ["part_id"], :name => "fk_parts_has_machines_parts1"

  create_table "materials", :force => true do |t|
    t.string  "name",            :limit => 45
    t.string  "description"
    t.integer "manufacturer_id"
    t.string  "type"
    t.text    "notes"
  end

  add_index "materials", ["manufacturer_id"], :name => "fk_manufacturer"

  create_table "materials_parts", :id => false, :force => true do |t|
    t.integer "materials_id", :null => false
    t.integer "parts_id",     :null => false
  end

  add_index "materials_parts", ["materials_id"], :name => "fk_materials_has_parts_materials1"
  add_index "materials_parts", ["parts_id"], :name => "fk_materials_has_parts_parts1"

  create_table "mechanical_properties", :primary_key => "material_id", :force => true do |t|
    t.string "breakpoint",                   :limit => 45
    t.string "yield_stress",                 :limit => 45
    t.string "elasticity",                   :limit => 45
    t.string "machinability",                :limit => 45
    t.string "biocompatibility",             :limit => 45
    t.string "wear_resistance",              :limit => 45
    t.string "density",                      :limit => 45
    t.string "particle_size",                :limit => 45
    t.string "fatigue_strength",             :limit => 45
    t.string "hardness",                     :limit => 45
    t.string "roughness",                    :limit => 45
    t.string "humidity_resistance",          :limit => 45
    t.string "elongation_at_breakpoint",     :limit => 45
    t.string "tensile_stress_at_breakpoint", :limit => 45
    t.string "compressive_strength",         :limit => 45
    t.string "flexural_strength",            :limit => 45
    t.string "tensile_strength",             :limit => 45
    t.string "torsion_shear",                :limit => 45
    t.string "abrasion_resistance",          :limit => 45
    t.string "impact_strength",              :limit => 45
    t.string "tensile_modulus",              :limit => 45
    t.string "tension_modulus",              :limit => 45
    t.string "elastic_modulus",              :limit => 45
    t.string "modulus_of_elasticity",        :limit => 45
    t.string "rupture_strength",             :limit => 45
    t.string "poissons_ratio",               :limit => 45
    t.string "ductility",                    :limit => 45
    t.string "surface_tension",              :limit => 45
    t.string "reduction_in_area",            :limit => 45
  end

  create_table "models", :force => true do |t|
    t.integer "cad_cam_software_id",                          :null => false
    t.integer "scanner_id",                                   :null => false
    t.integer "user_id",                                      :null => false
    t.integer "format_id",                                    :null => false
    t.string  "name",                           :limit => 45
    t.string  "description"
    t.string  "hash",                                         :null => false
    t.integer "version"
    t.text    "intended_use"
    t.text    "post_processing_recomendations"
    t.integer "licenses_id",                                  :null => false
    t.integer "recomended_material_id",                       :null => false
    t.integer "recomended_printer"
  end

  add_index "models", ["cad_cam_software_id"], :name => "fk_models_cad_cam_software1"
  add_index "models", ["format_id"], :name => "fk_models_formats1"
  add_index "models", ["licenses_id"], :name => "fk_models_licenses1"
  add_index "models", ["recomended_material_id"], :name => "fk_models_materials1"
  add_index "models", ["scanner_id"], :name => "fk_models_scanners1"
  add_index "models", ["user_id"], :name => "fk_models_users1"

  create_table "operating_environments", :force => true do |t|
  end

  create_table "operating_parameters", :id => false, :force => true do |t|
    t.integer "id",                       :null => false
    t.integer "part_id",                  :null => false
    t.integer "operating_environment_id", :null => false
  end

  add_index "operating_parameters", ["operating_environment_id"], :name => "fk_operating_parameters_operating_environments1"
  add_index "operating_parameters", ["part_id"], :name => "fk_operating_parameters_parts1"

  create_table "optical_properties", :force => true do |t|
    t.string "transmission_range", :limit => 45
    t.string "transparency",       :limit => 45
    t.string "refractive_index",   :limit => 45
    t.string "dispersion",         :limit => 45
  end

  create_table "parts", :id => false, :force => true do |t|
    t.integer "id",                       :null => false
    t.integer "property_id",              :null => false
    t.integer "intended_uses_id",         :null => false
    t.integer "optical_properties_id",    :null => false
    t.integer "mechanical_properties_id", :null => false
    t.integer "thermal_properties_id",    :null => false
    t.integer "electrical_properties_id", :null => false
    t.integer "chemical_properties_id",   :null => false
  end

  add_index "parts", ["chemical_properties_id"], :name => "fk_parts_chemical_properties1"
  add_index "parts", ["electrical_properties_id"], :name => "fk_parts_electrical_properties1"
  add_index "parts", ["intended_uses_id"], :name => "fk_parts_intended_uses1"
  add_index "parts", ["mechanical_properties_id"], :name => "fk_parts_mechanical_properties1"
  add_index "parts", ["optical_properties_id"], :name => "fk_parts_optical_properties1"
  add_index "parts", ["thermal_properties_id"], :name => "fk_parts_thermal_properties1"

  create_table "parts_composite_structures", :id => false, :force => true do |t|
    t.integer "part_id",       :null => false
    t.integer "assemblage_id", :null => false
  end

  add_index "parts_composite_structures", ["assemblage_id"], :name => "fk_parts_has_composite_structures_composite_structures1"
  add_index "parts_composite_structures", ["part_id"], :name => "fk_parts_has_composite_structures_parts1"

  create_table "parts_physical_test_methods", :id => false, :force => true do |t|
    t.integer "part_id",                 :null => false
    t.integer "physical_test_method_id", :null => false
  end

  add_index "parts_physical_test_methods", ["part_id"], :name => "fk_parts_has_physical_test_methods_parts1"
  add_index "parts_physical_test_methods", ["physical_test_method_id"], :name => "fk_parts_has_physical_test_methods_physical_test_methods1"

  create_table "parts_post_processing_techniques", :id => false, :force => true do |t|
    t.integer "parts_id",                      :null => false
    t.integer "post_processing_techniques_id", :null => false
  end

  add_index "parts_post_processing_techniques", ["parts_id"], :name => "fk_parts_has_post_processing_techniques_parts1"
  add_index "parts_post_processing_techniques", ["post_processing_techniques_id"], :name => "fk_parts_has_post_processing_techniques_post_processing_techn1"

  create_table "physical_test_methods", :force => true do |t|
    t.string "name",                :limit => 45
    t.string "description"
    t.text   "process_description"
  end

  create_table "post_processing_techniques", :force => true do |t|
  end

  create_table "scanner_technologies", :force => true do |t|
    t.integer "company_id",                :null => false
    t.string  "name",        :limit => 45
    t.string  "description"
    t.string  "url"
  end

  add_index "scanner_technologies", ["company_id"], :name => "fk_scanner_technologies_companies1"

  create_table "scanners", :id => false, :force => true do |t|
    t.integer "id",                                  :null => false
    t.integer "scanner_technology_id",               :null => false
    t.integer "company_id",                          :null => false
    t.string  "name",                  :limit => 45
    t.string  "description"
    t.string  "version",               :limit => 45
  end

  add_index "scanners", ["company_id"], :name => "fk_scanners_companies1"
  add_index "scanners", ["scanner_technology_id"], :name => "fk_scanners_scanner_technologies"

  create_table "software", :id => false, :force => true do |t|
    t.integer "id",        :null => false
    t.integer "system_id", :null => false
  end

  add_index "software", ["system_id"], :name => "fk_software_system1"

  create_table "system", :force => true do |t|
  end

  create_table "thermal_properties", :force => true do |t|
    t.string "fire_retardant",       :limit => 45
    t.string "melting_point",        :limit => 45
    t.string "heat_resistance",      :limit => 45
    t.string "cold_resistance",      :limit => 45
    t.string "insulator",            :limit => 45
    t.string "glass_transition",     :limit => 45
    t.string "crystallinity",        :limit => 45
    t.string "thermal_conductivity", :limit => 45
    t.string "specific_heat",        :limit => 45
    t.string "thermal_expansion",    :limit => 45
  end

  create_table "users", :force => true do |t|
    t.string    "first_name",          :limit => 45
    t.string    "last_name",           :limit => 45
    t.string    "login",               :limit => 45,                    :null => false
    t.string    "email",               :limit => 45,                    :null => false
    t.string    "crypted_password",                                     :null => false
    t.string    "password_salt",                                        :null => false
    t.timestamp "registration_date"
    t.string    "activation_hash"
    t.string    "persistence_token",                                    :null => false
    t.string    "single_access_token",                                  :null => false
    t.string    "perishable_token",                                     :null => false
    t.integer   "login_count",                       :default => 0,     :null => false
    t.integer   "failed_login_count",                :default => 0,     :null => false
    t.datetime  "last_request_at"
    t.datetime  "current_login_at"
    t.datetime  "last_login_at"
    t.string    "current_login_ip",    :limit => 45
    t.string    "last_login_ip",       :limit => 45
    t.boolean   "active",                            :default => false
  end

  create_table "versions", :force => true do |t|
    t.integer "model_id",           :null => false
    t.integer "version",            :null => false
    t.text    "change_description"
  end

  add_index "versions", ["model_id"], :name => "fk_versions_models1"

end
