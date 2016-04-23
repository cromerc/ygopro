--幻獣機ブルーインパラス
function c805000023.initial_effect(c)
	--synchro custom
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SYNCHRO_MATERIAL_CUSTOM)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTarget(c805000023.target)
	e1:SetValue(1)
	e1:SetOperation(c805000023.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(c805000023.synlimit)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetCondition(c805000023.indcon)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e4)
	--special summon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(805000023,0))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_GRAVE)
	e5:SetCondition(c805000023.spcon)
	e5:SetCost(c805000023.spcost)
	e5:SetTarget(c805000023.sptg)
	e5:SetOperation(c805000023.spop)
	c:RegisterEffect(e5)
end
c805000023.tuner_filter=aux.FALSE
function c805000023.filter(c,syncard,tuner,f,lv)
	return c:IsNotTuner() and c:IsSetCard(0x101b) and c:IsCanBeSynchroMaterial(syncard,tuner) and (f==nil or f(c)) and c:GetLevel()==lv
end
function c805000023.target(e,syncard,f,minc,maxc)
	if minc>1 then return false end
	local lv=syncard:GetLevel()-e:GetHandler():GetLevel()
	if lv<=0 then return false end
	return Duel.IsExistingMatchingCard(c805000023.filter,syncard:GetControler(),LOCATION_HAND+LOCATION_MZONE,0,1,nil,syncard,e:GetHandler(),f,lv)
end
function c805000023.operation(e,tp,eg,ep,ev,re,r,rp,syncard,f,minc,maxc)
	local lv=syncard:GetLevel()-e:GetHandler():GetLevel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c805000023.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,syncard,e:GetHandler(),f,lv)
	Duel.SetSynchroMaterial(g)
end
function c805000023.synlimit(e,c)
	if not c then return false end
	return not c:IsRace(RACE_MACHINE)
end
function c805000023.indcon(e)
	return Duel.IsExistingMatchingCard(Card.IsType,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil,TYPE_TOKEN)
end
function c805000023.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_MZONE,0)==0
		and Duel.GetFieldGroupCount(1-e:GetHandler():GetControler(),LOCATION_MZONE,0)>0
end
function c805000023.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c805000023.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,31533705,0x101b,0x4011,0,0,3,RACE_MACHINE,ATTRIBUTE_WIND) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c805000023.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,31533705,0x101b,0x4011,0,0,3,RACE_MACHINE,ATTRIBUTE_WIND) then
		local token=Duel.CreateToken(tp,31533705)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end