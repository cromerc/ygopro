--Don Thousand's Throne (Anime)
function c511000293.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--check
	local ch=Effect.CreateEffect(c)
	ch:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	ch:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	ch:SetRange(LOCATION_SZONE)
	ch:SetCode(EVENT_DAMAGE)
	ch:SetCondition(c511000293.checkcon)
	ch:SetOperation(c511000293.checkop)
	c:RegisterEffect(ch)
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000293,0))
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetLabelObject(ch)
	e2:SetCountLimit(1)
	e2:SetTarget(c511000293.rectg)
	e2:SetOperation(c511000293.recop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000293,1))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetCondition(c511000293.spcon)
	e3:SetCost(c511000293.spcost)
	e3:SetTarget(c511000293.sptg)
	e3:SetOperation(c511000293.spop)
	c:RegisterEffect(e3)
end
function c511000293.checkcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c511000293.checkop(e,tp,eg,ep,ev,re,r,rp)
	local val=e:GetLabel()+ev
	e:SetLabel(val)
end
function c511000293.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,e:GetLabelObject():GetLabel())
end
function c511000293.recop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Recover(p,e:GetLabelObject():GetLabel(),REASON_EFFECT)
	e:GetLabelObject():SetLabel(0)
end
function c511000293.spcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	local a=Duel.GetAttacker()
	local p=e:GetHandler():GetControler()
	return at:IsControler(tp) and at:IsFaceup() and at:IsType(TYPE_XYZ) and a:GetAttack()>Duel.GetLP(p)
end
function c511000293.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511000293.filter(c,e,tp,rank)
	local rk=c:GetRank()
	return (c:IsSetCard(0x1048) or c:IsSetCard(0x1073) or c:IsCode(511000296)) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and rk==rank+1
end
function c511000293.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local at=Duel.GetAttackTarget()
	if chk==0 then
		local rank=Duel.GetAttackTarget():GetRank()
		return rank and Duel.IsExistingMatchingCard(c511000293.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,rank)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000293.spop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.NegateAttack() then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_END,1,1)
	Duel.SkipPhase(1-tp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
	local tc=Duel.GetAttackTarget()
	if tc:IsFacedown() or not tc:IsRelateToBattle() or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000293.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc:GetRank())
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
