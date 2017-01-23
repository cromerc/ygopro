--波動竜騎士 ドラゴエクィテス
function c511002707.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c511002707.ffilter,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),true)
	--cannot spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetValue(c511002707.splimit)
	c:RegisterEffect(e1)
	--copy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(14017402,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c511002707.efftg)
	e2:SetOperation(c511002707.effop)
	c:RegisterEffect(e2)
	--reflect damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_REFLECT_DAMAGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetValue(c511002707.refcon)
	c:RegisterEffect(e3)
end
c511002707.miracle_synchro_fusion=true
function c511002707.ffilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsType(TYPE_SYNCHRO)
end
function c511002707.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c511002707.refcon(e,re,val,r,rp,rc)
	return bit.band(r,REASON_EFFECT)~=0 and rp~=e:GetHandler():GetControler() and e:GetHandler():IsAttackPos()
end
function c511002707.filter(c,fusc)
	return c:IsLocation(LOCATION_GRAVE) and bit.band(c:GetReason(),0x40008)==0x40008 and c:GetReasonCard()==fusc 
		and c:IsType(TYPE_SYNCHRO) and c:IsAbleToRemove()
end
function c511002707.efftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_GRAVE and c511002707.filter(chkc,e:GetHandler()) end
	if chk==0 then return Duel.IsExistingTarget(c511002707.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c511002707.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c511002707.effop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and c:IsFaceup() and tc:IsRelateToEffect(e) then
		if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0 then
			c:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000,1)
		end
	end
end
