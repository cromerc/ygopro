--Lock Dragon
function c511001213.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_NEGATED)
	e2:SetRange(LOCATION_HAND)
	e2:SetOperation(c511001213.chop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511001213,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_CHAIN_END)
	e3:SetRange(LOCATION_HAND)
	e3:SetCondition(c511001213.hspcon)
	e3:SetTarget(c511001213.hsptg)
	e3:SetOperation(c511001213.hspop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(1,1)
	e4:SetCondition(c511001213.atcon)
	c:RegisterEffect(e4)
end
function c511001213.chop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if rp==tp then return end
	local de,dp=Duel.GetChainInfo(ev,CHAININFO_DISABLE_REASON,CHAININFO_DISABLE_PLAYER)
	if de and dp==tp and de:GetHandler():IsType(TYPE_COUNTER) then
		local ty=re:GetActiveType()
		local flag=c:GetFlagEffectLabel(511001213)
		if not flag then
			c:RegisterFlagEffect(511001213,RESET_EVENT+0x1fe0000,0,0,ty)
			e:SetLabelObject(de)
		elseif de~=e:GetLabelObject() then
			e:SetLabelObject(de)
			c:SetFlagEffectLabel(511001213,ty)
		else
			c:SetFlagEffectLabel(511001213,bit.bor(flag,ty))
		end
	end
end
function c511001213.hspcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local label=c:GetFlagEffectLabel(511001213)
	if label~=nil and label~=0 then
		e:SetLabel(label)
		c:SetFlagEffectLabel(511001213,0)
		return true
	else return false end
end
function c511001213.hsptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511001213.hspop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
	end
end
function c511001213.atcon(e)
	return e:GetHandler():IsDefensePos()
end
