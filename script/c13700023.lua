-- Rune-Eyes Pendulum Dragon
function c13700023.initial_effect(c)	
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,16178681,c13700023.ffilter,1,true,true)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c13700023.valcheck)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c13700023.atkcon)
	e3:SetOperation(c13700023.atkop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
function c13700023.ffilter(c)
	return c:IsRace(RACE_SPELLCASTER)
end
function c13700023.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c13700023.valcheck(e,c)
	local g=c:GetMaterial()
	local atk=-1
	local tc=g:GetFirst()
	if tc:IsCode(16178681) or tc:IsHasEffect(EFFECT_FUSION_SUBSTITUTE) then tc=g:GetNext() end
	if not tc:IsCode(16178681) then
		level=tc:GetLevel()
	end
	e:SetLabel(level)
end
function c13700023.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local level=e:GetLabelObject():GetLabel()
	if e:GetLabelObject():GetLabel()<5 then
	local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
		e2:SetReset(RESET_EVENT+0x1ff0000)
		e2:SetCondition(c13700023.dircon)
		c:RegisterEffect(e2)
		local e3=e2:Clone()
		e3:SetCode(EFFECT_CANNOT_ATTACK)
		e3:SetCondition(c13700023.dircon2)
		c:RegisterEffect(e3)
	end
	if e:GetLabelObject():GetLabel()>4 then
	local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(2)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
		e2:SetReset(RESET_EVENT+0x1ff0000)
		e2:SetCondition(c13700023.dircon)
		c:RegisterEffect(e2)
		local e3=e2:Clone()
		e3:SetCode(EFFECT_CANNOT_ATTACK)
		e3:SetCondition(c13700023.dircon2)
		c:RegisterEffect(e3)
	end
		if  Duel.SelectYesNo(tp,aux.Stringid(13700023,0)) then
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_SINGLE)
		e5:SetCode(EFFECT_IMMUNE_EFFECT)
		e5:SetValue(c13700023.efilter)
		e5:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+RESET_END)
		c:RegisterEffect(e5)
	end
end

function c13700023.dircon(e)
	return e:GetHandler():GetAttackAnnouncedCount()>0
end
function c13700023.dircon2(e)
	return e:GetHandler():IsDirectAttacked()
end

function c13700023.efilter(e,re)
	return e:GetHandlerPlayer()~=re:GetHandlerPlayer()
end
