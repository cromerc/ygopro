--デステニー・ストリングス
function c100000211.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c100000211.target)
	e1:SetOperation(c100000211.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c100000211.eqlimit)
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)	
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)	
	e3:SetCondition(c100000211.tgcon)
	e3:SetTarget(c100000211.tgtg)
	e3:SetOperation(c100000211.tgop)
	c:RegisterEffect(e3)
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetCondition(c100000211.tgcon)
	e4:SetTarget(c100000211.tg)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
function c100000211.tg(e,c)
	return c==Duel.GetAttackTarget()
end
function c100000211.eqlimit(e,c)
	return c:IsSetCard(0x83)
end
function c100000211.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x83)
end
function c100000211.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c100000211.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000211.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c100000211.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c100000211.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c100000211.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler():GetEquipTarget()
end
function c100000211.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c100000211.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)	
	local ct=Duel.DiscardDeck(tp,1,REASON_EFFECT)	
	if ct==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()	
	if tc:IsType(TYPE_MONSTER) then			
		local ca=tc:GetLevel()-1	
		local c=e:GetHandler()
		local e1=Effect.CreateEffect(c:GetEquipTarget())		
		e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)	
		e1:SetCountLimit(ca)
		e1:SetLabel(ca)
		e1:SetCode(EVENT_DAMAGE_STEP_END)		
		e1:SetCondition(c100000211.atcon)
		e1:SetOperation(c100000211.atop)		
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:GetEquipTarget():RegisterEffect(e1)
	else
		Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end	
end
function c100000211.atcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabel()~=0
end
function c100000211.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
