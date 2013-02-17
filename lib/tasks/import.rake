desc 'import_clinics'
task :import_clinics => :environment do
  require 'csv'
  #---import services---
  services = {}
  services_seeds = [
    {:code => 'DEGS', :name => 'Donor Egg Services'},
    {:code => 'GS', :name => 'Gestational Surrogate'},
    {:code => 'DEMS', :name => 'Donor Embryo Services'},
    {:code => 'C', :name => 'Cryopreservation'},
    {:code => 'SW', :name => 'Services for Single Women'},
    {:code => 'AAL', :name => 'ACS Accredited Laboratory'},
    {:code => 'IS', :name => 'ICSI Services'},
    {:code => 'PGD', :name => 'Preimplantation Genetic Diagnosis'}
  ]

  services_seeds.each do |s|
    service = Service.create! s
    services[service[:code]] = service
  end

  #---import ages---
  ages_seeds = [
    {:code => '35', :name => '<35', :min => 0, :max => 34},
    {:code => '37', :name => '35-37', :min => 35, :max => 37},
    {:code => '40', :name => '38-40', :min => 38, :max => 40},
    {:code => '42', :name => '41-42', :min => 41, :max => 42},
    {:code => '44', :name => '43-44', :min => 43, :max => 44},
  ]

  ages_seeds.each do |a|
    Age.create! a
  end

  #---import conditions---
  conditions = {}
  conditions_seeds = [
    {:code => 'TF', :name => 'Tubal Factor'},
    {:code => 'OD', :name => 'Ovulatory Dysfunction'},
    {:code => 'DOR', :name => 'Diminished Ovarian Reserve'},
    {:code => 'E', :name => 'Endometriosis'},
    {:code => 'UF', :name => 'Uterine Factor'},
    {:code => 'MF', :name => 'Male Factor'},
    {:code => 'MFF', :name => 'Male and Female Factor'},
    {:code => 'FGD', :name => 'Familial Genetic Disease'}
  ]

  conditions_seeds.each do |c|
    condition = Condition.create! c
    conditions[condition[:code]] = condition
  end

  #---Link Conditions with Required Services---
  raise("OD requires assisted hatching, but this wasn't in our list of services that we know about")
  #conditions['OD'].services << services['']
  conditions['DOR'].services << services['DEGS']
  conditions['DOR'].services << services['DEMS']
  conditions['UF'].services << services['GS']
  conditions['MF'].services << services['ICSI']
  conditions['FGD'].services << services['PGD']
  conditions['MFF'].services << services['ICSI']

  conditions.each do |key, condition|
    condition.save!
  end

   #---import clinics---
  clinics = {}
  filename = File.join(Rails.root, 'db/seeds/clinics.csv')
  CSV.foreach(filename, :headers => true, :header_converters => :symbol) do |row|
    clinic = Clinic.create!({
        :name => row[:clinic_name],
        :address => row[:address],
        :city => row[:city],
        :state => row[:state],
        :zip => row[:zip],
        :practice_director => row[:practice_director],
        :medical_director => row[:medical_director],
        :lab_director => row[:lab_director],
        :phone => row[:phone],
        :fax => row[:fax],
        :link => row[:link],
        :email => row[:email]
      })

    clinics[row[:clinic_id]] = clinic

    service_codes = [
      :donor_egg,
      :gest_carrier,
      :donor_embryo,
      :cryopres,
      :single_women,
      :accred,
      :icsi,
      :pgd
    ]
    service_codes.each do |code|
      if row[code].to_s == '1'
        clinic.services << Service.find_by_code(code)
      end
    end

    clinic.save
  end
end