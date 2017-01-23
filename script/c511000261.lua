--Raviel, Emperor of Phantasmal Demons
function c511000261.initial_effect(c)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,1,511000261)
	--Cannot Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c511000261.spcon)
	e2:SetOperation(c511000261.spop)
	c:RegisterEffect(e2)
	--Create Token
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000261,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCondition(c511000261.tokencon)
	e3:SetTarget(c511000261.tokentg)
	e3:SetOperation(c511000261.tokenop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--Tribute to Increase ATK
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511000261,1))
	e5:SetCategory(CATEGORY_ATKCHANGE)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetCost(c511000261.increaseatkcost)
	e5:SetOperation(c511000261.increaseatkop)
	c:RegisterEffect(e5)
end
function c511000261.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c511000261.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c511000261.tokenfilter(c,tp)
	return c:IsControler(tp)
end
function c511000261.tokencon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000261.tokenfilter,1,nil,1-tp)
end
function c511000261.tokentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=eg:FilterCount(c511000261.tokenfilter,nil,1-tp)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ct,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct,0,0)
end
function c511000261.tokenop(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(c511000261.tokenfilter,nil,1-tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 or not Duel.IsPlayerCanSpecialSummonMonster(tp,69890968,0,0x4011,1000,1000,1,RACE_FIEND,ATTRIBUTE_DARK) then return end
	local i=0
	while i<ct do
		local token=Duel.CreateToken(tp,69890968)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e1,true)
		i=i+1
	end
end
function c511000261.increaseatkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,2,e:GetHandler()) end
	local g=Duel.SelectReleaseGroup(tp,nil,2,2,e:GetHandler())
	local atk=0
	local tc1=g:GetFirst()
	local tc2=g:GetNext()
	if tc1:IsFaceup() then atk=tc1:GetAttack() end
	if tc2:IsFaceup() then atk=atk+tc2:GetAttack() end
	if atk<0 then atk=0 end
	e:SetLabel(atk)
	Duel.Release(g,REASON_COST)
end
function c511000261.increaseatkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end