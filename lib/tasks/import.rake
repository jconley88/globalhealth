desc 'import'
task :import => :environment do
  require 'csv'
  #---import services---
  services = {}
  services_seeds = [
    {:code => 'degs', :name => 'Donor Egg Services'},
    {:code => 'gs', :name => 'Gestational Surrogate'},
    {:code => 'dems', :name => 'Donor Embryo Services'},
    {:code => 'c', :name => 'Cryopreservation'},
    {:code => 'sw', :name => 'Services for Single Women'},
    {:code => 'aal', :name => 'ACS Accredited Laboratory'},
    {:code => 'is', :name => 'ICSI Services'},
    {:code => 'pgd', :name => 'Preimplantation Genetic Diagnosis'}
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

  #---import complications---
  complications = {}
  complications_seeds = [
    {:code => 'tf', :name => 'tubal factor'},
    {:code => 'od', :name => 'ovulatory dysfunction'},
    {:code => 'dor', :name => 'diminished ovarian reserve'},
    {:code => 'e', :name => 'endometriosis'},
    {:code => 'uf', :name => 'uterine factor'},
    {:code => 'mf', :name => 'male factor'},
    {:code => 'mff', :name => 'male and female factor'},
    {:code => 'fgd', :name => 'Familial Genetic Disease'}
  ]

  complications_seeds.each do |c|
    complication = Complication.create! c
    complications[complication[:code]] = complication
  end

  #---Link Complications with Required Services---
  #raise("OD requires assisted hatching, but this wasn't in our list of services that we know about")
  #complications['OD'].services << services['']
  complications['dor'].services << services['degs']
  complications['dor'].services << services['dems']
  complications['uf'].services << services['gs']
  complications['mf'].services << services['is']
  complications['fgd'].services << services['pgd']
  complications['mff'].services << services['is']
  complications['tf'].services = Service.all
  complications['e'].services = Service.all

  complications.each do |key, complication|
    complication.save!
  end

   #---import clinics---
  clinics = {}
  filename = File.join(Rails.root, 'db/seeds/clinics.csv')
  CSV.foreach(filename, :headers => true, :header_converters => :symbol) do |row|
    clinic = Clinic.create!({
        :clinic_id => row[:clinic_id],
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
      :degs,
      :gs,
      :dems,
      :c,
      :sw,
      :aal,
      :is,
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