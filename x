
[1mFrom:[0m /home/action/.gem/ruby/2.1.1/gems/activerecord-4.0.0/lib/active_record/attribute_methods/read.rb @ line 78 ActiveRecord::AttributeMethods::Read#read_attribute:

    [1;34m75[0m: [1;31mdef[0m [1;34mread_attribute[0m(attr_name)
    [1;34m76[0m:   [0;34m# If it's cached, just return it[0m
    [1;34m77[0m:   [0;34m# We use #[] first as a perf optimization for non-nil values. See https://gist.github.com/jonleighton/3552829.[0m
 => [1;34m78[0m:   name = attr_name.to_s
    [1;34m79[0m:   @attributes_cache[name] || @attributes_cache.fetch(name) {
    [1;34m80[0m:     column = @columns_hash.fetch(name) {
    [1;34m81[0m:       [1;31mreturn[0m @attributes.fetch(name) {
    [1;34m82[0m:         [1;31mif[0m name == [32m[1;32m'[0m[32mid[1;32m'[0m[32m[0m && [1;36mself[0m.class.primary_key != name
    [1;34m83[0m:           read_attribute([1;36mself[0m.class.primary_key)
    [1;34m84[0m:         [1;31mend[0m
    [1;34m85[0m:       }
    [1;34m86[0m:     }
    [1;34m87[0m: 
    [1;34m88[0m:     value = @attributes.fetch(name) {
    [1;34m89[0m:       [1;31mreturn[0m block_given? ? [1;31myield[0m(name) : [1;36mnil[0m
    [1;34m90[0m:     }
    [1;34m91[0m: 
    [1;34m92[0m:     [1;31mif[0m [1;36mself[0m.class.cache_attribute?(name)
    [1;34m93[0m:       @attributes_cache[name] = column.type_cast(value)
    [1;34m94[0m:     [1;31melse[0m
    [1;34m95[0m:       column.type_cast value
    [1;34m96[0m:     [1;31mend[0m
    [1;34m97[0m:   }
    [1;34m98[0m: [1;31mend[0m

