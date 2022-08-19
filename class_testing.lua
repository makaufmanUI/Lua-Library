require 'class'     -- import the class module



------------------------
--    Account class   --
------------------------

-- constructor
Account = class(function(acc,balance)
    acc.balance = balance
end)

-- add Withdraw method
function Account:Withdraw(amount)
    self.balance = self.balance - amount
end

-- instantiate an Account object
local account = Account(1000)


print(account.balance)      -- initial balance from constructor
account:Withdraw(100)       -- withdraw 100 from the account
print(account.balance)      -- balance after withdrawal




------------------------------------------
--    Animal class and derived classes  --
------------------------------------------

-- constructor
Animal = class(function(a,name)
    a.name = name
end)

-- add method __tostring(), which Lua uses whenever
-- a string representation is needed of the object
function Animal:__tostring()
    return self.name..': '..self:Speak()
end

-- create Dog class that inherits from Animal,
-- and give it its own Speak() method
Dog = class(Animal)
function Dog:Speak()
    return 'bark'
end


-- create a Cat class that inherits from Animal,
-- and give it its own Speak() method
Cat = class(Animal, function(c,name,breed)
    Animal.init(c,name)  -- must init base!
    c.breed = breed
end)
function Cat:Speak()
    return 'meow'
end


-- create a Lion class that inherits from Cat,
-- and give it its own Speak() method
Lion = class(Cat)
function Lion:Speak()
    return 'roar'
end


-- instantiate objects from each class
local fido  = Dog('Fido')
local felix = Cat('Felix','Tabby')
local leo   = Lion('Leo','African')


-- test each class's __tostring() method via print()
print(fido)     -- Fido: bark
print(felix)    -- Felix: meow
print(leo)      -- Leo: roar

-- test each class's is_a() method to check class type
print(felix:is_a(Animal))   -- true
print(felix:is_a(Dog))      -- false
print(felix:is_a(Cat))      -- true
