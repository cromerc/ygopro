--Beastborg Wolf Kampfer
function c511002704.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c511002704.fusfilter1,c511002704.fusfilter2,true)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76539047,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511002704.damcon)
	e1:SetTarget(c511002704.damtg)
	e1:SetOperation(c511002704.damop)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(35952884,1))
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c511002704.sumcon)
	e2:SetTarget(c511002704.sumtg)
	e2:SetOperation(c511002704.sumop)
	c:RegisterEffect(e2)
end
function c511002704.fusfilter1(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_BEASTWARRIOR)
end
function c511002704.fusfilter2(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_MACHINE)
end
function c511002704.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c511002704.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(300)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,300)
end
function c511002704.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511002704.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c511002704.mgfilter(c,e,tp,fusc)
	return not c:IsControler(tp) or not c:IsLocation(LOCATION_GRAVE)
		or bit.band(c:GetReason(),0x40008)~=0x40008 or c:GetReasonCard()~=fusc
		or not c:IsCanBeSpecialSummoned(e,0,tp,false,false) or c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511002704.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg=e:GetHandler():GetMaterial()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if chk==0 then return mg:GetCount()>0 and ft>=mg:GetCount() 
		and not mg:IsExists(c511002704.mgfilter,1,nil,e,tp,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,mg,mg:GetCount(),tp,0)
end
function c511002704.sumop(e,tp,eg,ep,ev,re,r,rp)
	local mg=e:GetHandler():GetMaterial()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if mg:GetCount()>ft or mg:IsExists(c511002704.mgfilter,1,nil,e,tp,e:GetHandler()) then return end
	Duel.SpecialSummon(mg,0,tp,tp,false,false,POS_FACEUP)
end
