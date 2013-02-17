desc 'import_clinics'
task :import_clinics => :environment do
  require 'csv'
  require 'pp'
  #---import services---
  services_seeds = [
    {:code => 'donor_egg', :name => 'Donor Egg Services'},
    {:code => 'gest_carrier', :name => 'Surrogate Services'},
    {:code => 'donor_embryo', :name => 'Donor Embryo Services'},
    {:code => 'cryopres', :name => 'Cryopreservation'},
    {:code => 'single_women', :name => 'Services for Single Women'},
    {:code => 'accred', :name => 'ACS Accredited Laboratory'},
    {:code => 'icsi', :name => 'ICSI Services'},
    {:code => 'pgd', :name => 'Preimplantation Genetic Diagnosis'}
  ]

  services_seeds.each do |s|
    Service.create s
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
    Age.create a
  end

   #---import clinics---
  clinics = Hash.new()
  filename = File.join(Rails.root, 'db/seeds/clinics.csv')
  CSV.foreach(filename, :headers => true, :header_converters => :symbol) do |row|
    clinic = Clinic.create({
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